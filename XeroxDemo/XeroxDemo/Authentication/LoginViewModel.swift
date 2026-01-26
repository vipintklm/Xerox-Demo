//
//  LoginViewModel.swift
//  XeroxDemo
//
//  Created by vipin v on 24/01/26.
//

import Foundation

final class LoginViewModel {

    private let loginManager: LoginManaging
    private let tokenStore: TokenStore

    init(loginManager: LoginManaging,
         tokenStore: TokenStore = TokenStore()) {
        self.loginManager = loginManager
        self.tokenStore = tokenStore
    }

    // MARK: - Manual Login

    func login(completion: @escaping (Bool) -> Void) {

        loginManager.login { [weak self] token, _ in
            guard let self else {
                completion(false)
                return
            }

            if let token {
                self.tokenStore.save(token)
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    // MARK: - Silent Login

    func silentLogin(completion: @escaping (Bool) -> Void) {

        // Requirement: force logout if no network
        guard NetworkReachability.isReachable else {
            forceLogout()
            completion(false)
            return
        }

        guard tokenStore.fetch() != nil else {
            completion(false)
            return
        }

        loginManager.silentLogin { [weak self] token, _ in
            guard let self else {
                completion(false)
                return
            }

            if token != nil {
                completion(true)
            } else {
                self.forceLogout()
                completion(false)
            }
        }
    }

    // MARK: - Logout

    func forceLogout() {
        tokenStore.clear()
        loginManager.logout()
        DeviceRepository().deleteAll()

    }
}

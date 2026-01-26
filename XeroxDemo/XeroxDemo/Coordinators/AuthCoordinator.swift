//
//  AuthCoordinator.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import UIKit

final class AuthCoordinator {

    private let window: UIWindow
    private let loginManager = LoginManager()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        attemptSilentLogin()
    }

    private func attemptSilentLogin() {
        loginManager.silentLogin { [weak self] token, error in
            DispatchQueue.main.async {
                if token != nil {
                    // login success
                    self?.showHome()
                } else {
                    // login failed
                    self?.loginManager.logout()
                    self?.showLogin()
                }
            }
        }
    }

    private func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(
            withIdentifier: "LoginViewController"
        ) as! LoginViewController

        loginVC.onLoginSuccess = { [weak self] in
            self?.showHome()
        }

        let nav = UINavigationController(rootViewController: loginVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    private func showHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(
            withIdentifier: "HomeViewController"
        )

        let nav = UINavigationController(rootViewController: homeVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

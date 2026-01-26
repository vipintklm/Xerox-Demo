//
//  TokenStore.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import Foundation

final class TokenStore {

    private let tokenKey = "authToken"

    func save(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }

    func fetch() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}

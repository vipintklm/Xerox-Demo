//
//  HomeCoordinator.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import UIKit

final class HomeCoordinator {

    private let window: UIWindow
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        guard let homeVC = storyboard.instantiateViewController(
            withIdentifier: "HomeViewController"
        ) as? HomeViewController else {
            fatalError("HomeViewController not found in storyboard")
        }

        let navigationController = UINavigationController(rootViewController: homeVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

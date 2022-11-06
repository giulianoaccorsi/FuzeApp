//
//  AppCoordinator.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    let window: UIWindow

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        navigationController.navigationBar.prefersLargeTitles = true
        let matchesCoordinator = MatchesCoordinator(navigationController: navigationController)
        matchesCoordinator.start()
    }
}

//
//  SceneDelegate.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        coordinator = AppCoordinator(window: window, navigationController: UINavigationController())
        coordinator?.start()
    }
}


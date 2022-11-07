//
//  MatchesCoordinator.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import UIKit

protocol MatchesCoordinatorLogic: AnyObject {
    func showDetail(matchDetail: MatchDetail)
}

final class MatchesCoordinator: Coordinator, MatchesCoordinatorLogic {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let matchViewController = MatchFactory.make(coordinator: self)
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        matchViewController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(matchViewController, animated: true)
    }

    func showDetail(matchDetail: MatchDetail) {
        let detailCoordinator = MatchDetailCoordinator(
            navigationController: navigationController,
            match: matchDetail
        )
        detailCoordinator.start()
    }
}

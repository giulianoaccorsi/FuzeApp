//
//  MatchesCoordinator.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import UIKit

class MatchesCoordinator: Coordinator {
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

    func tappedDetail(match: MatchCellViewModel) {
        let detailCoordinator = MatchDetailCoordinator(navigationController: navigationController,
                                                       match: match)
        detailCoordinator.start()
    }
}

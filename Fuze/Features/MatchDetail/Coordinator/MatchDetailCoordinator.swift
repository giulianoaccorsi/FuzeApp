//
//  MatchDetailCoordinator.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 03/11/22.
//

import UIKit

protocol MatchDetailCoordinatorLogic: AnyObject {
    func back()
}

final class MatchDetailCoordinator: Coordinator, MatchDetailCoordinatorLogic {
    var navigationController: UINavigationController
    private let matchDetail: MatchDetail

    init(navigationController: UINavigationController,
         match: MatchDetail) {
        self.navigationController = navigationController
        self.matchDetail = match
    }

    func start() {
        let detailViewController = MatchDetailFactory.make(
            coordinator: self,
            matchDetail: matchDetail
        )
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(detailViewController, animated: true)
    }

    func back() {
        navigationController.popViewController(animated: true)
    }
}

//
//  MatchDetailCoordinator.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 03/11/22.
//

import UIKit

class MatchDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let match: MatchCellViewModel

    init(navigationController: UINavigationController,
         match: MatchCellViewModel) {
        self.navigationController = navigationController
        self.match = match
    }

    func start() {
        let detailViewController = MatchDetailFactory.make(
            coordinator: self,
            firstTeam: match.firstTeamID,
            secondTeam: match.secondTeamID,
            matchName: match.matchName,
            dateName: match.matchDate,
            opponents: match.opponentViewModel
        )
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(detailViewController, animated: true)
    }

    func back() {
        navigationController.popViewController(animated: true)
    }
}

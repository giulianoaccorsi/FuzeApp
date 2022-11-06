//
//  MatchDetailFactory.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 04/11/22.
//

import Foundation

enum MatchDetailFactory {
    static func make(coordinator: MatchDetailCoordinator,
                     firstTeam: String,
                     secondTeam: String,
                     matchName: String,
                     dateName: String,
                     opponents: OpponentsViewModel) -> MatchDetailViewController {

        let matchesView = MatchDetailView()

        let viewModel = MatchDetailViewModel(
            firstTeam: firstTeam,
            secondTeam: secondTeam,
            matchName: matchName,
            dateName: dateName,
            opponents: opponents
        )
        let viewController = MatchDetailViewController(
            matchDetailView: matchesView,
            viewModel: viewModel,
            coordinator: coordinator
        )
        viewModel.display = viewController

        return viewController
    }
}

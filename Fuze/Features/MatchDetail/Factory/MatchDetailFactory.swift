//
//  MatchDetailFactory.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 04/11/22.
//

import Foundation

enum MatchDetailFactory {
    static func make(
        coordinator: MatchDetailCoordinatorLogic,
        matchDetail: MatchDetail
    ) -> MatchDetailViewController {

        let matchesView = MatchDetailView()
        let viewModel = MatchDetailViewModel(matchDetail: matchDetail)
        let viewController = MatchDetailViewController(
            matchDetailView: matchesView,
            viewModel: viewModel,
            coordinator: coordinator
        )
        viewModel.display = viewController

        return viewController
    }
}

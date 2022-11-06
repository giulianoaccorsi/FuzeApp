//
//  MatchFactory.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 01/11/22.
//

import Foundation

enum MatchFactory {
    static func make(coordinator: MatchesCoordinator) -> MatchesViewController {
        let matchesView = MatchesView()
        let viewModel = MatchesViewModel()
        let viewController = MatchesViewController(matchesView: matchesView,
                                                   viewModel: viewModel,
                                                   coordinator: coordinator)
        viewModel.display = viewController

        return viewController
    }
}

//
//  MatchesViewModel.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import Foundation

protocol MatchesViewControllerLogic {
    func loadRunningMatches()
}

final class MatchesViewModel {
    weak var display: MatchesViewControllerDisplayable?
    private let service: PandaNetworkProtocol
    private var pageIndex: Int = 1
    private var isLoading = false

    init(service: PandaNetworkProtocol = PandaNetwork(getRequest: GetRequest())) {
        self.service = service
    }

    func loadRunningMatches() {
        Task {
            do {
                let matches = try await service.fetchAllMatchs(pageIndex: pageIndex)
                self.display?.displayMatches(matches: converterToMatchCellViewModel(matches: matches))
            } catch let error as ServiceError {
                self.display?.displayError(error: error)
            }
        }
    }

    func loadMoreMatches() {
        pageIndex += 1
        if !isLoading {
            isLoading = true
            Task {
                do {
                    let matches = try await service.fetchMoreMatches(pageIndex: pageIndex)
                    isLoading = false
                    self.display?.displayMoreMatches(matches: converterToMatchCellViewModel(matches: matches))
                } catch let error as ServiceError {
                    self.display?.displayError(error: error)
                }
            }
        }
    }

    private func converterToMatchCellViewModel(matches: [Match]) -> [MatchCellViewModel] {
        let viewModels: [MatchCellViewModel] = matches.map { match in
            return MatchCellViewModel(match: match)
        }

        return viewModels
    }
}

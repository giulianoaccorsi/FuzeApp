//
//  MatchDetailViewModel.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 03/11/22.
//


import Foundation

protocol MatchDetailViewControllerLogic {
    func loadPlayers()
}

final class MatchDetailViewModel: MatchDetailViewControllerLogic {
    weak var display: MatchDetailViewControllerDisplayable?
    private let service: PandaNetworkProtocol
    private let firstTeamID: String
    private let secondTeamID: String
    private let matchName: String
    private let dateName: String
    private let opponents: OpponentsViewModel

    init(firstTeam: String,
         secondTeam: String,
         matchName: String,
         dateName: String,
         opponents: OpponentsViewModel,
         service: PandaNetworkProtocol = PandaNetwork(getRequest: GetRequest())) {
        self.service = service
        self.firstTeamID = firstTeam
        self.secondTeamID = secondTeam
        self.matchName = matchName
        self.dateName = dateName
        self.opponents = opponents
    }

    func loadPlayers() {
        Task {
            do {
                let players = try await service.fetchAllPlayers(firstTeamID: firstTeamID, secondTeamID: secondTeamID)
                display?.displayMatches(matches: convertMatchCellViewModel(players: players),
                                        leagueName: matchName,
                                        matchDate: dateName,
                                        opponents: opponents)
            } catch let error as ServiceError {
                display?.displayError(error: error)
            }
        }
    }

    func convertMatchCellViewModel(players: (first: [Player], second: [Player])) -> [MatchDetailCellViewModel] {
        let result = zip(players.first, players.second).map {
            return MatchDetailCellViewModel(players: (firstTeam: $0, secondTeam: $1))
        }
        return result
    }
}

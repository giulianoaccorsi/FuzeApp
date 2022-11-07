//
//  MatchDetailViewModel.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 03/11/22.
//


import Foundation

protocol MatchDetailViewModelLogic {
    func loadPlayers()
}

final class MatchDetailViewModel: MatchDetailViewModelLogic {
    weak var display: MatchDetailViewControllerDisplayable?
    private let service: PandaNetworkProtocol
    private let matchDetail: MatchDetail
    
    init(
        matchDetail: MatchDetail,
        service: PandaNetworkProtocol = PandaNetwork(
            getRequest: GetRequest()
        )) {
            self.service = service
            self.matchDetail = matchDetail
        }
    
    func loadPlayers() {
        Task {
            do {
                let players = try await service.fetchAllPlayers(firstTeamID: matchDetail.firstTeamID, secondTeamID: matchDetail.secondTeamID)
                display?.displayMatches(matches: convertMatchCellViewModel(players: players),
                                        leagueName: matchDetail.matchName,
                                        matchDate: matchDetail.dateName,
                                        opponents: matchDetail.opponents)
            } catch let error as ServiceError {
                display?.displayError(error: error)
            }
        }
    }
    
    func convertMatchCellViewModel(
        players: (first: [Player], second: [Player])
    ) -> [MatchDetailCellViewModel] {
        let result = zip(players.first, players.second).map {
            return MatchDetailCellViewModel(players: (firstTeam: $0, secondTeam: $1))
        }
        return result
    }
}

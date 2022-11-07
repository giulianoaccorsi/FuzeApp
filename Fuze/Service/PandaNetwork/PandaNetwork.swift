//
//  PandaNetwork.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import Foundation

final class PandaNetwork {
    private let getRequest: GetRequestable
    private let token = "ynq2OlKndvM584ijPWI1l03cK-9EUUTd60IE_vhWPWj_aza4yLE"
    
    init(getRequest: GetRequestable) {
        self.getRequest = getRequest
    }
}

extension PandaNetwork: PandaNetworkProtocol {
    func fetchAllPlayers(
        firstTeamID: String,
        secondTeamID: String
    ) async throws -> (first: [Player], second: [Player]) {
        let first = try await fetchTeamPlayers(teamID: firstTeamID)
        let second = try await fetchTeamPlayers(teamID: secondTeamID)
        
        return (first, second)
    }
    
    func fetchAllMatchs(pageIndex: Int) async throws -> [Match] {
        var matches: [Match] = []
        let running = try await fetchRunningMatch()
        matches.append(contentsOf: running)
        let upcoming = try await fetchUpcomingMatches(pageIndex: pageIndex)
        matches.append(contentsOf: upcoming)
        return matches
    }
    
    func fetchMoreMatches(pageIndex: Int) async throws -> [Match] {
        let upcoming = try await fetchUpcomingMatches(pageIndex: pageIndex)
        return upcoming
    }
    
    private func fetchTeamPlayers(teamID: String) async throws -> [Player] {
        return try await getRequest.get(
            urlString: "https://api.pandascore.co/csgo/players",
            queryItems: [URLQueryItem(name: "token",
                                      value: token),
                         URLQueryItem(name: "filter[team_id]",
                                      value: "\(teamID)")],
            httpMethod: .get,
            parser: [Player].self
        )
    }
    
    private func fetchRunningMatch() async throws -> [Match] {
        return try await getRequest.get(
            urlString: "https://api.pandascore.co/csgo/matches/running",
            queryItems: [URLQueryItem(name: "token",
                                      value: token)],
            httpMethod: .get,
            parser: [Match].self
        )
    }
    
    private func fetchUpcomingMatches(pageIndex: Int) async throws -> [Match] {
        return try await getRequest.get(
            urlString: "https://api.pandascore.co/csgo/matches/upcoming",
            queryItems: [URLQueryItem(name: "token",
                                      value: token),
                         URLQueryItem(name: "page", value: "\(pageIndex)")],
            httpMethod: .get,
            parser: [Match].self
        )
    }
}

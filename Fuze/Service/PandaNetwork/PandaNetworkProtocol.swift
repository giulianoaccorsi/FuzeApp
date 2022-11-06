//
//  PandaNetworkProtocol.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import Foundation
protocol PandaNetworkProtocol {
    func fetchAllMatchs(pageIndex: Int) async throws -> [Match]
    func fetchMoreMatches(pageIndex: Int) async throws -> [Match]
    func fetchAllPlayers(firstTeamID: String, secondTeamID: String) async throws -> (first: [Player], second: [Player])
}

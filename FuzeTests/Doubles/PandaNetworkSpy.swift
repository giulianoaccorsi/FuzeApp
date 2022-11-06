//
//  PandaNetworkSpy.swift
//  FuzeTests
//
//  Created by Giuliano Accorsi on 06/11/22.
//

@testable import Fuze
import Foundation

final class PandaNetworkSpy: PandaNetworkProtocol {
    func fetchAllMatchs(pageIndex: Int) async throws -> [Fuze.Match] {
        return [.fixture(), .fixture(), .fixture()]
    }

    func fetchMoreMatches(pageIndex: Int) async throws -> [Fuze.Match] {
        return [.fixture()]
    }

    func fetchAllPlayers(firstTeamID: String, secondTeamID: String) async throws -> (first: [Fuze.Player], second: [Fuze.Player]) {
        return ([.fixture()], [.fixture()])
    }
}

//
//  Fixture+Match.swift
//  FuzeTests
//
//  Created by Giuliano Accorsi on 06/11/22.
//

@testable import Fuze

extension Match {
    static func fixture(id: Int? = 0,
                        league: League = .fixture(),
                        beginAt: String? = "",
                        opponents: [Teams] = [],
                        status: String? = "",
                        serie: Serie = .fixture()) -> Self {
        .init(id: id, league: league, beginAt: beginAt, opponents: opponents, status: status, serie: serie)
    }
}

//
//  Fixture+Teams.swift
//  FuzeTests
//
//  Created by Giuliano Accorsi on 06/11/22.
//

import Foundation
@testable import Fuze

extension Teams {
    static func fixture(opponent: Team = .fixture(),
                        type: String? = "") -> Self {
        .init(opponent: opponent, type: type)
    }
}

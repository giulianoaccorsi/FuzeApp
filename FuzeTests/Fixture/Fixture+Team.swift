//
//  Fixture+Team.swift
//  FuzeTests
//
//  Created by Giuliano Accorsi on 06/11/22.
//

import Foundation
@testable import Fuze

extension Team {
    static func fixture(id: Int? = 0,
                        imageURL: String? = "",
                        name: String? = "") -> Self {
        .init(id: id, imageURL: imageURL, name: name)
    }
}

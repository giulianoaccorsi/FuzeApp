//
//  Fixture+League.swift
//  FuzeTests
//
//  Created by Giuliano Accorsi on 06/11/22.
//

import Foundation
@testable import Fuze

extension League {
    static func fixture(imageURL: String? = "",
                        name: String? = "") -> Self {
        .init(imageURL: imageURL, name: name)
    }
}

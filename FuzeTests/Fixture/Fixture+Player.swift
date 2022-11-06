//
//  Fixture+Player.swift
//  FuzeTests
//
//  Created by Giuliano Accorsi on 06/11/22.
//

import Foundation
@testable import Fuze

extension Player {
    static func fixture(imageURL: String? = "",
                        firstName: String? = "",
                        lastName: String? = "",
                        name: String? = "") -> Self {
        .init(imageURL: imageURL,
              firstName: firstName,
              lastName: lastName,
              name: name)
    }
}

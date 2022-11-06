//
//  Fixture+Serie.swift
//  FuzeTests
//
//  Created by Giuliano Accorsi on 06/11/22.
//

import Foundation
@testable import Fuze

extension Serie {
    static func fixture(fullName: String? = "") -> Self {
        .init(fullName: fullName)
    }
}

//
//  OpponentsViewModel.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import Foundation
final class Opponents {
    let firstTeamImage: String
    let firstTeamLabel: String
    let secondTeamImage: String
    let secondTeamLabel: String

    init(firstTeamImage: String,
         firstTeamLabel: String,
         secondTeamImage: String,
         secondTeamLabel: String) {
        self.firstTeamImage = firstTeamImage
        self.firstTeamLabel = firstTeamLabel
        self.secondTeamImage = secondTeamImage
        self.secondTeamLabel = secondTeamLabel
    }
}

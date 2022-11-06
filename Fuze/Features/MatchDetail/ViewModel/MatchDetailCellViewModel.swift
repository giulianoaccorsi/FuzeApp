//
//  MatchDetailCellViewModel.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 04/11/22.
//


import UIKit

final class MatchDetailCellViewModel {
    private let players: (firstTeam: Player, secondTeam: Player)

    init(players: (firstTeam: Player, secondTeam: Player)) {
        self.players = players
    }

    var nickPlayerLabel: String {
        players.firstTeam.name ?? ""
    }

    var namePlayerLabel: String {
        "\(players.firstTeam.firstName ?? "") \(players.firstTeam.lastName ?? "")"
    }

    var playerImageView: URL? {
        URL(string: players.firstTeam.imageURL ?? "")
    }

    var nickSecondPlayerLabel: String {
        players.secondTeam.name ?? ""
    }

    var nameSecondPlayerLabel: String {
        "\(players.secondTeam.firstName ?? "") \(players.secondTeam.lastName ?? "")"
    }

    var playerSecondImageView: URL? {
        URL(string: players.secondTeam.imageURL ?? "")
    }

    var placeHolder: UIImage? {
        UIImage(named: "player-placeholder")
    }
}

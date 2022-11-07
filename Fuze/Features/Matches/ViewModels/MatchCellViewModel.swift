//
//  MatchCellViewModel.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 01/11/22.
//

import UIKit

final class MatchCellViewModel {
    private let match: Match

    init(match: Match) {
        self.match = match
    }

    private let dateFormatter: DateFormatter = {
        let relativeDateFormatter = DateFormatter()
        relativeDateFormatter.timeStyle = .short
        relativeDateFormatter.dateStyle = .short
        relativeDateFormatter.locale = Locale.current
        relativeDateFormatter.doesRelativeDateFormatting = true

        return relativeDateFormatter
    }()

    private let inputFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return dateFormatter
    }()

    private var firstTeamImage: String {
        match.opponents.first?.opponent.imageURL ?? ""
    }

    private var firstTeamLabel: String {
        match.opponents.first?.opponent.name ?? ""
    }

    private var secondTeamImage: String {
        return match.opponents.count == 2 ? match.opponents[1].opponent.imageURL ?? "" : ""
    }

    private var secondTeamLabel: String {
        return match.opponents.count == 2 ? match.opponents[1].opponent.name ?? "" : ""
    }

    var opponents: Opponents{
        return Opponents(
            firstTeamImage: firstTeamImage,
            firstTeamLabel: firstTeamLabel,
            secondTeamImage: secondTeamImage,
            secondTeamLabel: secondTeamLabel
        )
    }

    var leagueImageView: String {
        match.league.imageURL ?? String()
    }

    var status: TypeView {
        switch match.status {
        case TypeView.notStarted.rawValue:
            return .notStarted
        case TypeView.running.rawValue:
            return .running
        default:
            return .other
        }
    }

    var matchDate: String {
        if status == .running {
            return .running
        }
        let date = inputFormatter.date(from: match.beginAt ?? "")
        guard let date = date else { return "" }
        let result = dateFormatter.string(from: date)
        return result
    }

    var matchName: String {
        "\(match.league.name ?? "") - \(match.serie.fullName ?? "")"
    }

    var firstTeamID: String {
        "\(match.opponents.first?.opponent.id ?? 0)"
    }

    var secondTeamID: String {
        "\(match.opponents.last?.opponent.id ?? 0)"
    }

    var leagueImageUrl: URL? {
        URL(string: match.league.imageURL ?? "")
    }

    var imagePlaceHolder: UIImage? {
        UIImage(named: "placeholder")
    }
}

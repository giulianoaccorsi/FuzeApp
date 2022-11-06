//
//  RunningMatch.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import Foundation

// MARK: - RunningMatch
struct Match: Decodable {
    let id: Int?
    let league: League
    let beginAt: String?
    let opponents: [Teams]
    let status: String?
    let serie: Serie

    enum CodingKeys: String, CodingKey {
        case id, league, opponents, serie, status
        case beginAt = "begin_at"
    }
}

// MARK: - League
struct League: Decodable {
    let imageURL: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name
    }
}

// MARK: - Teams
struct Teams: Decodable {
    let opponent: Team
    let type: String?
}

// MARK: - Team
struct Team: Decodable {
    let id: Int?
    let imageURL: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

// MARK: - Serie
struct Serie: Decodable {
    let fullName: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}

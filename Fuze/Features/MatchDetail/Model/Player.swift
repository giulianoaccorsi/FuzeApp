//
//  Player.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import Foundation
struct Player: Decodable {
    let imageURL: String?
    let firstName, lastName, name: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case firstName = "first_name"
        case lastName = "last_name"
        case name
    }
}

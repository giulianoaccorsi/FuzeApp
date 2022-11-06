//
//  GetRequestable.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import Foundation

protocol GetRequestable {
    func get<T: Decodable> (urlString: String, queryItems: [URLQueryItem]?, httpMethod: HTTPMethod, parser: T.Type) async throws -> T
}

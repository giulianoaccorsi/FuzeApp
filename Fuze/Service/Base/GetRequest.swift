//
//  GetRequest.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

enum HTTPMethod: String {
    case get = "GET"
}

import Foundation

final class GetRequest: GetRequestable {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func get<T>(
        urlString: String,
        queryItems: [URLQueryItem]?,
        httpMethod: HTTPMethod,
        parser: T.Type
    ) async throws -> T where T : Decodable {
        var url = URLComponents(string: urlString)

        if let queryItems {
            url?.queryItems = queryItems
        }

        guard let url = url?.url else { throw ServiceError.badURL }
        
        do {
            let (data, response) = try await session.data(from: url)

            guard let response = response as? HTTPURLResponse else {
                throw ServiceError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
            case 401:
                throw ServiceError.unauthorized
            default:
                throw ServiceError.invalidStatusCode(response.statusCode)
            }
        } catch {
            throw ServiceError.unknown
        }
    }
}

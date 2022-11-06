//
//  ServiceError.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import Foundation
enum ServiceError: Error {
    case badURL
    case taskError
    case noResponse
    case invalidStatusCode(Int)
    case unauthorized
    case unknown

    var localizedDescription: String {
        switch self {
        case .badURL:
            return "URL Inválida :("
        case .taskError:
            return "Erro na Requisição"
        case .noResponse:
            return "Servidor não respondeu"
        case .invalidStatusCode(let statusCode):
            return "Status Code Inválido - \(statusCode)"
        case .unknown:
            return "Erro desconhecido"
        case .unauthorized:
            return "Não autorizado"
        }
    }
}

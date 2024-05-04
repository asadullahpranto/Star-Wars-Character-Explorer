//
//  RequestError.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatus
    case unknown
    
    var errorMessage: String {
        switch self {
        case .decode:
            return "Decoding error"
        case .invalidURL:
            return "Invalid url"
        case .noResponse:
            return "No response"
        case .unauthorized:
            return "Unauthorized user"
        case .unexpectedStatus:
            return "Unexpected status code"
        case .unknown:
            return "Unknown error"
        }
    }
}

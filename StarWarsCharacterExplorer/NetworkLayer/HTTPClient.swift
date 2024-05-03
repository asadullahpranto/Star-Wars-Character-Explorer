//
//  HTTPClient.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation
import Alamofire
import Combine

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> AnyPublisher<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> AnyPublisher<T, RequestError> {
        
        // populate url components from Endpoint
//        var urlComponent = URLComponents()
//        urlComponent.scheme = endpoint.scheme
//        urlComponent.host = endpoint.host
//        urlComponent.path = endpoint.path
//        urlComponent.queryItems = endpoint.queryItems
        
        guard let url = URL(string: endpoint.url) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        let request = AF.request(url, method: endpoint.method, headers: endpoint.headers)
        
        return request
            .publishDecodable(type: T.self)
            .tryMap { response in
                if let value = response.value {
                    return value
                } else {
                    throw RequestError.unknown
                }
            }
            .mapError { error in
                handleError(for: error)
            }
            .eraseToAnyPublisher()
    }
    
    private func handleError(for error: Error) -> RequestError {
        if let afError = error as? AFError {
            switch afError {
            case .responseValidationFailed(reason: .unacceptableStatusCode(let code)):
  
                if code == 401 {
                    return RequestError.unauthorized
                } else {
                    return RequestError.unexpectedStatus
                }
            default:
                return RequestError.unknown
            }
        } else {
            return RequestError.unknown
        }
    }
}

//
//  CharacterDetailsService.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation
import Combine

protocol CharacterDetailServiceable {
    func getStarshipDetails(by url: String) -> AnyPublisher<Starship, RequestError>
    func getPlanetDetails(by url: String) -> AnyPublisher<Planet, RequestError>
}

struct CharacterDetailService: HTTPClient, CharacterDetailServiceable {
    func getPlanetDetails(by url: String) -> AnyPublisher<Planet, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.getDetailsBy(url: url), responseModel: Planet.self)
    }
    
    func getStarshipDetails(by url: String) -> AnyPublisher<Starship, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.getDetailsBy(url: url), responseModel: Starship.self)
    }
}

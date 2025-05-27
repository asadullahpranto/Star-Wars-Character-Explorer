//
//  CharacterDetailsService.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation
import Combine

protocol CharacterDetailServiceable {
    func getStarshipDetails(by url: String) -> AnyPublisher<StarshipWrapper, RequestError>
    func getPlanetDetails(by url: String) -> AnyPublisher<PlanetWrapper, RequestError>
}

struct CharacterDetailService: HTTPClient, CharacterDetailServiceable {
    func getPlanetDetails(by url: String) -> AnyPublisher<PlanetWrapper, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.getDetailsBy(url: url), responseModel: PlanetWrapper.self)
    }
    
    func getStarshipDetails(by url: String) -> AnyPublisher<StarshipWrapper, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.getDetailsBy(url: url), responseModel: StarshipWrapper.self)
    }
}

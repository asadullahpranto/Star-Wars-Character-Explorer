//
//  CharacterDetailsService.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation
import Combine

protocol CharacterDetailServiceable {
    func getFilmDetails(by url: String) -> AnyPublisher<FilmInfo, RequestError>
    func getSpeciesDetails(by url: String) -> AnyPublisher<SpeciesInfo, RequestError>
}

struct CharacterDetailService: HTTPClient, CharacterDetailServiceable {
    func getSpeciesDetails(by url: String) -> AnyPublisher<SpeciesInfo, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.characterDetailsBy(url: url), responseModel: SpeciesInfo.self)
    }
    
    func getFilmDetails(by url: String) -> AnyPublisher<FilmInfo, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.characterDetailsBy(url: url), responseModel: FilmInfo.self)
    }
}

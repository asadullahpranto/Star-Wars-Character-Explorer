//
//  CharacterListService.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation
import Combine

protocol CharacterListServiceable {
    func getCharactersList(from url: String) -> AnyPublisher<PeopleResponse, RequestError>
}

class CharacterListService: HTTPClient, CharacterListServiceable {
    
    func getCharactersList(from url: String) -> AnyPublisher<PeopleResponse, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.charactersList(url: url), responseModel: PeopleResponse.self)
    }
}

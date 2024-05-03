//
//  CharacterListService.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation
import Combine

protocol CharacterListServiceable {
    func getCharactersList(from url: String) -> AnyPublisher<CharacterList, RequestError>
}

class CharacterListService: HTTPClient, CharacterListServiceable {
    
    func getCharactersList(from url: String) -> AnyPublisher<CharacterList, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.charactersList(url: url), responseModel: CharacterList.self)
    }
}

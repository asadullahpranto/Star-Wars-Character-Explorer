//
//  CharacterListService.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation
import Combine

protocol CharacterListServiceable {
    func getCharactersList(for pageNo: Int) -> AnyPublisher<CharacterList, RequestError>
}

class CharacterListService: HTTPClient, CharacterListServiceable {
    
    func getCharactersList(for pageNo: Int) -> AnyPublisher<CharacterList, RequestError> {
        return sendRequest(endpoint: SWApiEndpoint.charactersListFor(page: pageNo), responseModel: CharacterList.self)
    }
}

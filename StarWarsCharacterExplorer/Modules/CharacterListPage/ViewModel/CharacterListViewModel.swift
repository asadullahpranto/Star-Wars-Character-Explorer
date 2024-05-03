//
//  CharacterListViewModel.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/28/24.
//

import Foundation
import Combine

class CharacterListViewModel {
    let characterListService = CharacterListService()
    var cancellables = Set<AnyCancellable>()
    let firstPageUrl = "https://swapi.dev/api/people/?page=1"
    
    @Published var characterList: CharacterList?
    
    func getCharacterList(from url: String) {
        characterListService.getCharactersList(from: url)
            .sink { completion in
                // Handle completion
                switch completion {
                case .finished:
                    // Request completed successfully
                    break
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            } receiveValue: { response in
                self.characterList = response
                print("Response: \(response)")
            }
            .store(in: &cancellables)
        
    }
}

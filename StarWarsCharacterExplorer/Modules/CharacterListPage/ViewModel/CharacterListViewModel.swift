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
    @Published var characterList: CharacterList?
    
    func getCharacterList() {
        characterListService.getCharactersList(for: 1)
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

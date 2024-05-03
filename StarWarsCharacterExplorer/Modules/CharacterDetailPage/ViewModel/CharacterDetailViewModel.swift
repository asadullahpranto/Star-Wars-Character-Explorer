//
//  CharacterDetailViewModel.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation
import Combine

class CharacterDetailViewModel {
    private let charDetailService = CharacterDetailService()
    var cancellables = Set<AnyCancellable>()
    
    @Published var filmPublisher = PassthroughSubject<FilmInfo?, RequestError>()
    
    func getFilmDetail(by url: String) {
        charDetailService.getFilmDetails(by: url)
            .sink { completion in
                // Handle completion
                switch completion {
                case .finished:
                    // Request completed successfully
                    break
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                    self.filmPublisher.send(completion: .failure(error))
                }
            } receiveValue: { response in
                self.filmPublisher.send(response)
                print("Response: \(response)")
            }
            .store(in: &cancellables)
    }
}

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
    
    @Published var allStarship: [Starship]?
    @Published var planet: Planet?
    
    private var starships = [Starship]()
    
    func getPlanetDetail(for url: String) {
        charDetailService.getPlanetDetails(by: url)
            .sink { [weak self] completion in
                guard let self else { return }

                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            } receiveValue: { [weak self] planet in
                guard let self else { return }
                
                self.planet = planet
            }
            .store(in: &cancellables)
    }
    
    func getStarshipsDetail(for urls: [String]) {
        let group = DispatchGroup()
        
        for url in urls {
            group.enter()
            charDetailService.getStarshipDetails(by: url)
                .sink { [weak self] completion in
                    guard let self else { return }

                    switch completion {
                    case .finished:
                        break
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                    group.leave()
                } receiveValue: { [weak self] starship in
                    guard let self else { return }
                    
                    self.starships.append(starship)
                }
                .store(in: &cancellables)
        }
        
        group.notify(queue: .main) {
            self.allStarship = self.starships
        }
    }
}

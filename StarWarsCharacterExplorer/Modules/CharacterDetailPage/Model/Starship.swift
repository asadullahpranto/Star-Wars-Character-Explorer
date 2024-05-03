//
//  FilmInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

struct Starship: Hashable, Codable {
    let name: String
    let model: String
    let manufacturer: String
    let maxAtmospheringSpeed: String
    let starshipClass: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case starshipClass = "starship_class"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(model)
        hasher.combine(manufacturer)
        hasher.combine(maxAtmospheringSpeed)
        hasher.combine(starshipClass)
    }
}



//
//  SWCharacterInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation

struct CharacterList: Codable, Hashable {
    var nextPage: String?
    var previousPage: String?
    var list: [CharacterInfo]
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "next"
        case previousPage = "previous"
        case list = "results"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nextPage)
        hasher.combine(previousPage)
        hasher.combine(list)
    }
    
    static func == (lhs: CharacterList, rhs: CharacterList) -> Bool {
        return lhs.previousPage == rhs.previousPage && lhs.nextPage == rhs.nextPage && lhs.list == rhs.list
    }
}

struct CharacterInfo: Codable, Hashable {
    var name: String
    var height: String
    var mass: String
    var hairColor: String
    var skinColor: String
    var eyeColor: String
    var birthYear: String
    var gender: String
    var homeworld: String
    var films: [String]
    var species: [String]
    var vehicles: [String]
    var starships: [String]
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case height = "height"
        case mass = "mass"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender = "gender"
        case homeworld = "homeworld"
        case films = "films"
        case species = "species"
        case vehicles = "vehicles"
        case starships = "starships"
        case url = "url"
    }
}

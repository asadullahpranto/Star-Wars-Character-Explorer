//
//  SWCharacterInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation

struct CharacterList: Decodable, Hashable {
    let nextPage: String?
    let previousPage: String?
    let list: [CharacterInfo]
    
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

struct CharacterInfo: Decodable, Hashable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let url: String
    
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

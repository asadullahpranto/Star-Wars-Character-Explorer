//
//  SWCharacterInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation

// MARK: - Main Response
struct PeopleResponse: Codable, Hashable {
    let count: Int
    let pages: Int
    let next: String?
    let previous: String?
    let results: [PersonWrapper]
}

// MARK: - Person Wrapper
struct PersonWrapper: Codable, Hashable {
    let fields: Person
}

// MARK: - Person Fields
struct Person: Codable, Hashable {
    let edited: String
    let name: String
    let created: String
    let gender: String
    let skinColor: String
    let hairColor: String
    let height: String
    let eyeColor: String
    let mass: String
    let homeworld: String
    let birthYear: String
    let species: [String]
    let films: [String]
    let vehicles: [String]
    let starships: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case edited, name, created, gender
        case skinColor = "skin_color"
        case hairColor = "hair_color"
        case height, eyeColor = "eye_color"
        case mass, homeworld
        case birthYear = "birth_year"
        case species, films, vehicles, starships, url
    }
}


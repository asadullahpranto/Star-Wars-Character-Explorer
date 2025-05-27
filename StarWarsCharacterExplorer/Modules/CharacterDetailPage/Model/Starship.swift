//
//  FilmInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

struct StarshipsResponse: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let previous: String?
    let results: [StarshipWrapper]
}

struct StarshipWrapper: Codable {
    let fields: Starship
}

struct Starship: Codable {
    let pilots: [String]
    let MGLT: String
    let starshipClass: String
    let hyperdriveRating: String
    let films: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case pilots, MGLT, films, url
        case starshipClass = "starship_class"
        case hyperdriveRating = "hyperdrive_rating"
    }
}




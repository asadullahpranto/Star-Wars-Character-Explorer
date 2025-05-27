//
//  SpeciesInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

struct PlanetsResponse: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let previous: String?
    let results: [PlanetWrapper]
}

struct PlanetWrapper: Codable {
    let fields: Planet
}

struct Planet: Codable {
    let edited: String
    let climate: String
    let surfaceWater: String
    let name: String
    let diameter: String
    let rotationPeriod: String
    let created: String
    let terrain: String
    let gravity: String
    let orbitalPeriod: String
    let population: String
    let residents: [String]
    let films: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case edited, climate, name, diameter, created, terrain, gravity, population, residents, films, url
        case surfaceWater = "surface_water"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
    }
}



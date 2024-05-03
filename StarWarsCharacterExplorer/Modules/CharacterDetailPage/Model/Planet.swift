//
//  SpeciesInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

enum DisplayableItem: Hashable {
    case planet(Planet)
    case starship(Starship)

    static func == (lhs: DisplayableItem, rhs: DisplayableItem) -> Bool {
        switch (lhs, rhs) {
        case let (.planet(planet1), .planet(planet2)):
            return planet1 == planet2
        case let (.starship(starship1), .starship(starship2)):
            return starship1 == starship2
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case let .planet(planet):
            hasher.combine(planet)
        case let .starship(starship):
            hasher.combine(starship)
        }
    }
}


struct Planet: Hashable, Codable {
    let name: String
    let rotationPeriod: String
    let climate: String
    let gravity: String
    let population: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case climate
        case gravity
        case population
    }
}


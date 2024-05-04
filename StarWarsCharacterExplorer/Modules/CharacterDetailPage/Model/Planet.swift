//
//  SpeciesInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

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


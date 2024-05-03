//
//  FilmInfo.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

struct FilmInfo: Codable {
    var title: String
    var director: String
    var producer: String
    var releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case director = "director"
        case producer = "producer"
        case releaseDate = "release_date"
    }
}

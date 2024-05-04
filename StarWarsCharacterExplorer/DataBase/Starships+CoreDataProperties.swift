//
//  Starships+CoreDataProperties.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 4/5/24.
//
//

import Foundation
import CoreData


extension Starships {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Starships> {
        return NSFetchRequest<Starships>(entityName: "Starships")
    }

    @NSManaged public var manufacturer: String?
    @NSManaged public var maxAtmospheringSpeed: String?
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var starshipClass: String?
    @NSManaged public var characters: Characters?

}

extension Starships : Identifiable {

}

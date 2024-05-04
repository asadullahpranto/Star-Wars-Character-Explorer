//
//  Planets+CoreDataProperties.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 4/5/24.
//
//

import Foundation
import CoreData


extension Planets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planets> {
        return NSFetchRequest<Planets>(entityName: "Planets")
    }

    @NSManaged public var climate: String?
    @NSManaged public var gravity: String?
    @NSManaged public var name: String?
    @NSManaged public var population: String?
    @NSManaged public var rotationPeriod: String?
    @NSManaged public var character: Characters?

}

extension Planets : Identifiable {

}

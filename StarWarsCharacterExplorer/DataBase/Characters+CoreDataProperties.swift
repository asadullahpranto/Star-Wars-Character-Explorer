//
//  Characters+CoreDataProperties.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 4/5/24.
//
//

import Foundation
import CoreData


extension Characters {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Characters> {
        return NSFetchRequest<Characters>(entityName: "Characters")
    }

    @NSManaged public var birthYear: String?
    @NSManaged public var eyeColor: String?
    @NSManaged public var gender: String?
    @NSManaged public var hairColor: String?
    @NSManaged public var height: String?
    @NSManaged public var homeworldId: String?
    @NSManaged public var mass: String?
    @NSManaged public var name: String?
    @NSManaged public var skinColor: String?
    @NSManaged public var planets: Planets?
    @NSManaged public var starships: NSSet?

}

// MARK: Generated accessors for starships
extension Characters {

    @objc(addStarshipsObject:)
    @NSManaged public func addToStarships(_ value: Starships)

    @objc(removeStarshipsObject:)
    @NSManaged public func removeFromStarships(_ value: Starships)

    @objc(addStarships:)
    @NSManaged public func addToStarships(_ values: NSSet)

    @objc(removeStarships:)
    @NSManaged public func removeFromStarships(_ values: NSSet)

}

extension Characters : Identifiable {

}

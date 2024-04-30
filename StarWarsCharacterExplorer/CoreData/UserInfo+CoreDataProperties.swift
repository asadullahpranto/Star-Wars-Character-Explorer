//
//  UserInfo+CoreDataProperties.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/30/24.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var parentName: String?
    @NSManaged public var phoneNumber: String?

}

extension UserInfo : Identifiable {

}

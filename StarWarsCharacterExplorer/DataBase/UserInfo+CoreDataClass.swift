//
//  UserInfo+CoreDataClass.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/30/24.
//
//

import Foundation
import CoreData
import UIKit

enum CoreDataError: Error {
    case saveError
    case fetchError
    case updateError
    case unknown
}

@objc(UserInfo)
public class UserInfo: NSManagedObject {
    
    private static var container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    class func isAlreadyRegistered(using email: String) async -> Bool {
        let request: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        let viewContext = container?.viewContext
        
        do {
            let results = try viewContext?.fetch(request)
            if let userInfo = results?.first {
                return true
            }
            
            return false
            
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    class func addOrUpdateToDB(for userInfo: UserCredential) {
        container?.performBackgroundTask {
            context in
            do{
                let person = UserInfo(context: context)
                person.name = userInfo.name
                person.email = userInfo.email
                person.gender = userInfo.gender
                person.parentName = userInfo.parentName
                person.phoneNumber = userInfo.phone
                try context.save()
                
            } catch {
                print("DB ERROR: \(error.localizedDescription)")
            }
        }
    }

    class func fetchUser(using email: String?) async -> Result<UserInfo, CoreDataError> {
        let request: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        if let email {
            request.predicate = NSPredicate(format: "email == %@", email)
        }
        
        let viewContext = container?.viewContext

        do {
            let results = try viewContext?.fetch(request)
            if let userInfo = results?.first {
                return .success(userInfo)
            }
            
            return .failure(CoreDataError.unknown)
            
        } catch {
            print(error.localizedDescription)
            return .failure(CoreDataError.fetchError)
        }
    }
}

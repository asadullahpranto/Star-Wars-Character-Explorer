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
    
    class func addOrUpdateToDB(for userInfo: UserCredential, completion: @escaping (Bool) -> Void) {
        guard let context = container?.newBackgroundContext() else { return }
        
        context.automaticallyMergesChangesFromParent = true
        
        let fetchRequest: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", userInfo.email)
        
        context.perform {
            do {
                let result = try context.fetch(fetchRequest)
                
                if let user = result.first {
                    let _ = updateUser(for: user, with: userInfo)
                    
                } else {
                    var userObj = UserInfo(context: context)
                    userObj = updateUser(for: userObj, with: userInfo)
                }
                
                try context.save()
                completion(true)
            } catch {
                print("DB ERROR: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    

    class func fetchUser(using email: String?, completion: @escaping (Result<UserInfo, CoreDataError>) -> Void) {
        
        guard let context = container?.viewContext else { return }
        
        do {
            let fetchRequest: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
            if let email {
                fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            }
            do {
                let results = try context.fetch(fetchRequest)
                
                if let userInfo = results.first {
                    completion(.success(userInfo))
                } else {
                    completion(.failure(CoreDataError.unknown))
                }
            } catch {
                completion(.failure(CoreDataError.fetchError))
            }
        }
    }
    
    class func loginLogout(using email: String?, isLoging: Bool, completion: @escaping (Result<Bool, CoreDataError>) -> Void) {
        
        guard let context = container?.viewContext else { return }
        
        do {
            let fetchRequest: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
            if let email {
                fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            }
            do {
                let results = try context.fetch(fetchRequest)
                
                if let userInfo = results.first {
                    userInfo.isLoggedIn = isLoging
                    try context.save()
                    completion(.success(true))
                } else {
                    completion(.failure(CoreDataError.unknown))
                }
            } catch {
                completion(.failure(CoreDataError.fetchError))
            }
        }
    }
    
    private class func updateUser(for user: UserInfo, with userInfo: UserCredential) -> UserInfo {
        user.name = userInfo.name
        user.email = userInfo.email
        user.gender = userInfo.gender
        user.parentName = userInfo.parentName
        user.phoneNumber = userInfo.phone
        user.isLoggedIn = true
        
        return user
    }
}

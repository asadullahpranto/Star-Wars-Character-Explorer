//
//  Characters+CoreDataClass.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 4/5/24.
//
//

import UIKit
import CoreData

@objc(Characters)
public class Characters: NSManagedObject {
    
    private static var container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    class func addOrUpdateToDB(for charInfo: CharacterInfo?, planet: Planet?, starships: [Starship], completion: @escaping (Bool) -> Void) {
        guard let context = container?.newBackgroundContext() else { return }
        
        context.automaticallyMergesChangesFromParent = true
        
        context.perform {
            do {
                let char = Characters(context: context)
                char.name = charInfo?.name
                char.mass = charInfo?.mass
                char.height = charInfo?.height
                char.hairColor = charInfo?.hairColor
                char.skinColor = charInfo?.skinColor
                char.eyeColor = charInfo?.eyeColor
                char.gender = charInfo?.gender
                char.homeworldId = charInfo?.homeworld
                
                for a in starships {
                    let ship = Starships(context: context)
                    ship.name = a.name
                    ship.model = a.model
                    char.addToStarships(ship)
                }
                
                let p = Planets(context: context)
                p.name = planet?.name
                p.population = planet?.population
                
                char.planets = p
                
                try context.save()
                completion(true)
            } catch {
                print("DB ERROR: \(error.localizedDescription)")
                completion(false)
            }
        }
//        container?.performBackgroundTask {
//            context in
//            do{
//                let person = UserInfo(context: context)
//                person.name = userInfo.name
//                person.email = userInfo.email
//                person.gender = userInfo.gender
//                person.parentName = userInfo.parentName
//                person.phoneNumber = userInfo.phone
//                try context.save()
//
//            } catch {
//                print("DB ERROR: \(error.localizedDescription)")
//            }
//        }
    }

    class func fetchCharacters(using email: String?, completion: @escaping (Result<Characters, CoreDataError>) -> Void) {
        
        guard let context = container?.viewContext else { return }
        
        do {
            let fetchRequest: NSFetchRequest<Characters> = Characters.fetchRequest()
            if let email {
                fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            }
            do {
                let results = try context.fetch(fetchRequest)
                
                if let userInfo = results.first {
                    completion(.success(userInfo))
                    print(userInfo.name, "name")
                    print(userInfo.height, "height")
                } else {
                    completion(.failure(CoreDataError.unknown))
                }
            } catch {
                completion(.failure(CoreDataError.fetchError))
            }
        }
    }
}

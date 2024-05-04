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
    
    class func addOrUpdateToDB(for charInfo: CharacterInfo, planet: Planet?, starships: [Starship], completion: @escaping (Bool) -> Void) {
        guard let context = container?.newBackgroundContext() else { return }
        
        context.automaticallyMergesChangesFromParent = true
        
        let fetchRequest: NSFetchRequest<Characters> = Characters.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "homeworldId == %@", charInfo.homeworld)
        
        context.perform {
            do {
                let result = try context.fetch(fetchRequest)
                
                var charObj: Characters
                
                if let character = result.first {
                    charObj = character
                    
                } else {
                    charObj = Characters(context: context)
                }
                
                charObj.name = charInfo.name
                charObj.mass = charInfo.mass
                charObj.height = charInfo.height
                charObj.hairColor = charInfo.hairColor
                charObj.skinColor = charInfo.skinColor
                charObj.eyeColor = charInfo.eyeColor
                charObj.gender = charInfo.gender
                charObj.homeworldId = charInfo.homeworld
                
                for a in starships {
                    let ship = Starships(context: context)
                    ship.name = a.name
                    ship.model = a.model
                    charObj.addToStarships(ship)
                }
                
                let p = Planets(context: context)
                p.name = planet?.name
                p.population = planet?.population
                
                charObj.planets = p
                
                try context.save()
                completion(true)
            } catch {
                print("DB ERROR: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    class func fetchCharacters(completion: @escaping (Result<[Characters], CoreDataError>) -> Void) {
        
        guard let context = container?.viewContext else { return }
        
        do {
            let fetchRequest: NSFetchRequest<Characters> = Characters.fetchRequest()

            do {
                var characters = [CharacterInfo]()
                let results = try context.fetch(fetchRequest)
                
                completion(.success(results))
                
            } catch {
                completion(.failure(CoreDataError.fetchError))
            }
        }
    }
    
//    private func convertModel(form chars: [Characters]) -> [CharacterInfo] {
//        for char in chars {
//            let character = CharacterInfo(
//                name: result.name ?? "",
//                height: result.height,
//                mass: result.mass,
//                hairColor: result.hairColor,
//                skinColor: result.skinColor,
//                eyeColor: result.eyeColor,
//                birthYear: result.birthYear,
//                gender: result.gender,
//                homeworld: result.homeworldId,
//                films: [""],
//                species: [""],
//                vehicles: [""],
//                starships: result.starships,
//                url: result.homeworldId
//            )
//        }
//    }
}

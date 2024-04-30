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

@objc(UserInfo)
public class UserInfo: NSManagedObject {
    
    private static var container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    class func saveOrUpdateToDB(iconsListData: Data, container: NSPersistentContainer?) {
        container?.performBackgroundTask{
            context in
            do{
                try context.save()
            } catch {
                print("DB ERROR: \(error.localizedDescription)")
            }
        }
    }

    class func fetchDataFromDB(iconsListData: Data, container: NSPersistentContainer?) {
        container?.performBackgroundTask{ context in
//            let request: NSFetchRequest<LogoMakerIcons> = LogoMakerIcons.fetchRequest()
            do {
//                let results = try context.fetch(request)
//                if results.count > 0 {
//                    let iconData = results[0]
//                    iconData.json = iconsListData as NSData
//                    try context.save()
//                }
            } catch {
                print("DB ERROR: \(error.localizedDescription)")
            }
        }
    }
}

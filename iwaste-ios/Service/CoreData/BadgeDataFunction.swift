//
//  BadgeDataFunction.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/11/20.
//

import UIKit
import CoreData

class BadgeDataFunction {
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    static func retrieveAllBadgeData() -> [DataBadge] {
        var dataBadges = [DataBadge]()
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.badgeEntity)
            
            do {
                let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                
                results?.forEach { (data) in
                    dataBadges.append(
                        DataBadge(
                            num: data.value(forKey: K.Core.badgeNum) as! Int,
                            date: data.value(forKey: K.Core.badgeDate) as! Date
                        )
                    )
                }
            } catch let err {
                print("failed to load data badge: ", err.localizedDescription)
            }
        }
        
        return dataBadges
    }
    
    static func saveBadgeData(num: Int, date: Date) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: K.Core.badgeEntity, in: managedContext) else {return}
            
            let insert = NSManagedObject(entity: entity, insertInto: managedContext)
            insert.setValue(num, forKey: K.Core.badgeNum)
            insert.setValue(date, forKey: K.Core.badgeDate)
            
            do {
                try managedContext.save()
            } catch let err {
                print("failed to save data badge: ", err.localizedDescription)
            }
        }
    }
}

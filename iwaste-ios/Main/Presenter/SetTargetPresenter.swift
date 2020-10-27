//
//  SetTargetPresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 27/10/20.
//

import UIKit
import CoreData

class SetTargetPresenter {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func addCategoryTarget(name: String, target: Int) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let catEntity = NSEntityDescription.entity(forEntityName: "CategoryCD", in: managedContext)
            
            let trashCategory = NSManagedObject(entity: catEntity!, insertInto: managedContext)
            
            trashCategory.setValue(Date(), forKey: "date")
            trashCategory.setValue(target, forKey: "target")
            trashCategory.setValue(name, forKey: "name")
            
            do {
                try managedContext.save()
            } catch let err {
                print("error save category data: ", err)
            }
        }
    }
    
    func addDataTrash() {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let trashEntity = NSEntityDescription.entity(forEntityName: "TrashCD", in: managedContext)
            
            for singleWaste in dataWaste {
                let waste = singleWaste.waste
                for n in 0...waste.count-1 {
                    let newTrash = NSManagedObject(entity: trashEntity!, insertInto: managedContext)
                    
                    newTrash.setValue(Date(), forKey: "date")
                    newTrash.setValue(singleWaste.categoryName, forKey: "type")
                    newTrash.setValue(waste[n].wasteName, forKey: "name")
                    
                    do {
                        try managedContext.save()
                    } catch let err {
                        print("error save trash data: ", err)
                    }
                }
            }
            
        }
    }
}

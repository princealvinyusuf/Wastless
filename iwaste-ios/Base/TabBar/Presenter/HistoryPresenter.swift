//
//  HistoryPresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Raihan on 01/11/20.
//

import UIKit
import CoreData


class HistoryPresenter{
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let trashList: [String] = ["Plastic", "Glass", "Paper", "Metal", "Organic"]
    let categoryList: [String] = ["APlastic", "BGlass", "CPaper", "DMetal", "EOrganic"]
    
    func getTrashData(date: String, completion: @escaping (_ totalTrash : [Int], _ targetCategory : [Int])->()){
        var trashes = [TrashCD]()
        var category = [CategoryCD]()
        var totalTrashCount: [Int] = []
        var totalCategoryTarget: [Int] = []

        if let appDelegate = appDelegate {
            totalTrashCount.removeAll()
            totalCategoryTarget.removeAll()
            //TRASH DATA
            for trash in trashList{
                let managedContext = appDelegate.persistentContainer.viewContext
                let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
                
                //Predicate
                let datePredicate = NSPredicate(format: "date=%@", date)
                let typePredicate = NSPredicate(format: "type=%@", trash)
                
                trashRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [datePredicate, typePredicate])
                do {
                    try trashes = managedContext.fetch(trashRequest)
                } catch {
                    print("Error Data could not be shown")
                }
                
                
                var countOfWaste = 0
                for ttrash in trashes{
                    countOfWaste += Int(truncatingIfNeeded: ttrash.count)
                }
                totalTrashCount.append(countOfWaste)
            }
            
            //CATEGORY DATA
            for cat in categoryList{
                let managedContext = appDelegate.persistentContainer.viewContext
                let catRequest: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
                
                //Predicate
                let datePredicate = NSPredicate(format: "date=%@", date)
                let namePredicate = NSPredicate(format: "name=%@", cat)
                
                catRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [datePredicate, namePredicate])

                do {
                    try category = managedContext.fetch(catRequest)
                }catch{
                    print("Error data could not be shown")
                }
                if category.count == 0{
                    
                }else{
                    let cat = category[0]
                    totalCategoryTarget.append(Int(truncatingIfNeeded: cat.target))
                }
                
            }
            
            completion(totalTrashCount,totalCategoryTarget)
            
            
            
        }
    }
    
    func getTotalWaste(date: String, completion: @escaping (_ totalWaste: Int) ->()){
        var totalWaste = 0
        if let appDelegate = appDelegate {
            var trashes = [TrashCD]()
            let managedContext = appDelegate.persistentContainer.viewContext
            let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
            
            //Predicate
            let datePredicate = NSPredicate(format: "date=%@", date)
            trashRequest.predicate = datePredicate
            do {
                try trashes = managedContext.fetch(trashRequest)
            } catch {
                print("Error Data could not be shown")
            }
            
            if trashes.count>0{
                for ttrash in trashes{
                    totalWaste += Int(truncatingIfNeeded: ttrash.count)
                }
            }else{
                print("NILAI KOSONG")
                totalWaste = 0
            }
            
            
            completion(totalWaste)
            
        }
    }
}

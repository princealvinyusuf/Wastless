//
//  HistoryPresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Raihan on 01/11/20.
//

import UIKit
import CoreData
import Foundation


class HistoryPresenter{
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let trashList: [String] = ["Plastic", "Glass", "Paper", "Metal", "Organic"]
    let categoryList: [String] = ["APlastic", "BGlass", "CPaper", "DMetal", "EOrganic"]
    var totalTrashCount: [Int] = []
    var totalCategoryTarget: [Int] = []
    
    func getTotalWasteDaily(date: String, completion: @escaping (_ totalTrash : [Int], _ targetCategory : [Int], _ total: Int)->()){
        var trashes = [TrashCD]()
        var category = [CategoryCD]()
        var total = 0
        totalTrashCount.removeAll()
        totalCategoryTarget.removeAll()

        if let appDelegate = appDelegate {
            
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
                    total += Int(truncatingIfNeeded: ttrash.count)
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
            
            completion(totalTrashCount,totalCategoryTarget,total)
            
            
            
        }
    }
    
    
    func getTotalWasteMonthly(date: Date, completion: @escaping (_ totalTrash : [Int], _ totalTarget : [Int], _ total: Int)->()){
        let monthFormatter = DateFormatter()
        let yearFormatter = DateFormatter()
        
        monthFormatter.dateFormat = "MM"
        yearFormatter.dateFormat = "yyyy"
        
        
        let month = monthFormatter.string(from: date)
        let year = yearFormatter.string(from: date)
//        let month="11"
//        let year="2020"
        
        var totalWasteWeekly = 0
        var totalTargetWeekly = 0
        var total = 0
        totalTrashCount.removeAll()
        totalCategoryTarget.removeAll()
        
        //Week 1
        for i in 1...8{
            let day = String(format: "%02d", i)
            let date = ("\(day)/\(month)/\(year)")
            getTrashDataMonthly(date: date){(totalTrash, totalTarget) in
                totalWasteWeekly += totalTrash
                totalTargetWeekly += totalTarget
                total += totalTrash
            }
        }
        totalTrashCount.append(totalWasteWeekly)
        totalCategoryTarget.append(totalTargetWeekly)
        totalWasteWeekly = 0
        totalTargetWeekly = 0
        
        //Week 2
        for i in 9...16{
            let day = String(format: "%02d", i)
            let date = ("\(day)/\(month)/\(year)")
            getTrashDataMonthly(date: date){(totalTrash, totalTarget) in
                totalWasteWeekly += totalTrash
                totalTargetWeekly += totalTarget
                total += totalTrash
            }
        }
        totalTrashCount.append(totalWasteWeekly)
        totalCategoryTarget.append(totalTargetWeekly)
        totalWasteWeekly = 0
        totalTargetWeekly = 0
        

        //Week 3
        for i in 17...24{
            let day = String(format: "%02d", i)
            let date = ("\(day)/\(month)/\(year)")
            getTrashDataMonthly(date: date){(totalTrash, totalTarget) in
                totalWasteWeekly += totalTrash
                totalTargetWeekly += totalTarget
                total += totalTrash
            }
        }
        totalTrashCount.append(totalWasteWeekly)
        totalCategoryTarget.append(totalTargetWeekly)
        totalWasteWeekly = 0
        totalTargetWeekly = 0
        

        //Week 4
        for i in 25...31{
            let day = String(format: "%02d", i)
            let date = ("\(day)/\(month)/\(year)")
            getTrashDataMonthly(date: date){(totalTrash, totalTarget) in
                totalWasteWeekly += totalTrash
                totalTargetWeekly += totalTarget
                total += totalTrash
            }
        }
        totalTrashCount.append(totalWasteWeekly)
        totalCategoryTarget.append(totalTargetWeekly)
        
        completion(totalTrashCount, totalCategoryTarget, total)

        
    }
    
    func getTrashDataMonthly(date:String, completion: @escaping (_ totalTrashCount: Int, _ totalTargetCount: Int) -> ()){
        var trashes = [TrashCD]()
        var category = [CategoryCD]()
        var totalTrashCount: [Int] = []
        var totalCategoryTarget: [Int] = []

        if let appDelegate = appDelegate {
            totalTrashCount.removeAll()
            totalCategoryTarget.removeAll()
            let datePredicate = NSPredicate(format: "date=%@", date)
            
            //TRASH DATA
            let managedContext = appDelegate.persistentContainer.viewContext
            let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
            trashRequest.predicate = datePredicate
            do {
                try trashes = managedContext.fetch(trashRequest)
            } catch {
                print("Error Data could not be shown")
            }
            var countOfWaste = 0
            for ttrash in trashes{
                countOfWaste += Int(truncatingIfNeeded: ttrash.count)
            }
            
            
            //CATEGORY DATA
            let catRequest: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
            catRequest.predicate = datePredicate
            do {
                try category = managedContext.fetch(catRequest)
            }catch{
                print("Error data could not be shown")
            }
            var countOfTarget = 0
            if category.count == 0{
                
            }else{
                for ccategory in category{
                    countOfTarget += Int(truncatingIfNeeded: ccategory.target)
                }
            }
            
            completion(countOfWaste, countOfTarget)
            
        }
    }
    
    func getTotalWasteWeekly(date: [Date], completion: @escaping (_ totalTrash : [Int], _ totalTarget : [Int], _ total: Int)->()){
        var trashes = [TrashCD]()
        var category = [CategoryCD]()
        var total = 0
        totalTrashCount.removeAll()
        totalCategoryTarget.removeAll()
        
        let dayFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        let yearFormatter = DateFormatter()
        
        dayFormatter.dateFormat = "dd"
        monthFormatter.dateFormat = "MM"
        yearFormatter.dateFormat = "yyyy"
        
        for dates in date{
            let day = dayFormatter.string(from: dates)
            let month = monthFormatter.string(from: dates)
            let year = yearFormatter.string(from: dates)
            let date = ("\(day)/\(month)/\(year)")
            
            
            if let appDelegate = appDelegate{
                let managedContext = appDelegate.persistentContainer.viewContext
                let datePredicate = NSPredicate(format: "date=%@", date)
                
                //TRASH DATA
                let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
                trashRequest.predicate = datePredicate
                do {
                    try trashes = managedContext.fetch(trashRequest)
                } catch {
                    print("Error Data could not be shown")
                }
                var countOfWaste = 0
                for ttrash in trashes{
                    countOfWaste += Int(truncatingIfNeeded: ttrash.count)
                    total += Int(truncatingIfNeeded: ttrash.count)
                }
                totalTrashCount.append(countOfWaste)
                
                
                //CATEGORY DATA
                let catRequest: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
                catRequest.predicate = datePredicate
                do {
                    try category = managedContext.fetch(catRequest)
                }catch{
                    print("Error data could not be shown")
                }
                var countOfTarget = 0
                if category.count == 0{
                    
                }else{
                    for ccategory in category{
                        countOfTarget += Int(truncatingIfNeeded: ccategory.target)
                    }
                }
                totalCategoryTarget.append(countOfTarget)
            }
        }
        completion(totalTrashCount, totalCategoryTarget, total)
        
    }
}

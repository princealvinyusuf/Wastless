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
    let trashList: [String] = [NSLocalizedString("trashlist_plastic", comment: "Plastic"), NSLocalizedString("trashlist_glass", comment: "Glass"), NSLocalizedString("trashlist_glass", comment: "Paper"), NSLocalizedString("trashlist_metal", comment: "Metal"), NSLocalizedString("trashlist_organic", comment: "Organic")]
    let categoryList: [String] = [NSLocalizedString("categorylist_plastic", comment: "APlastic"), NSLocalizedString("categorylist_glass", comment: "BGlass"), NSLocalizedString("categorylist_paper", comment: "CPaper"), NSLocalizedString("categorylist_metal", comment: "DMetal"), NSLocalizedString("categorylist_organic", comment: "EOrganic")]
    var totalTrashCount: [Int] = []
    var totalCategoryTarget: [Int] = []
    
    func getTrashData(date: String, completion: @escaping (_ totalTrash : [Int], _ targetCategory : [Int])->()){
        var trashes = [TrashCD]()
        var category = [CategoryCD]()
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

                totalWaste = 0
            }
            
            
            completion(totalWaste)
            
        }
    }
    
    func getTotalWasteWeekly(date: Date, completion: @escaping (_ totalTrash : [Int], _ totalTarget : [Int])->()){
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
        totalTrashCount.removeAll()
        totalCategoryTarget.removeAll()
        
        //Week 1
        for i in 1...8{
            let day = String(format: "%02d", i)
            let date = ("\(day)/\(month)/\(year)")
            getTrashDataWeekly(date: date){(totalTrash, totalTarget) in
                totalWasteWeekly += totalTrash
                totalTargetWeekly += totalTarget
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
            getTrashDataWeekly(date: date){(totalTrash, totalTarget) in
                totalWasteWeekly += totalTrash
                totalTargetWeekly += totalTarget
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
            getTrashDataWeekly(date: date){(totalTrash, totalTarget) in
                totalWasteWeekly += totalTrash
                totalTargetWeekly += totalTarget
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
            getTrashDataWeekly(date: date){(totalTrash, totalTarget) in
                totalWasteWeekly += totalTrash
                totalTargetWeekly += totalTarget
            }
        }
        totalTrashCount.append(totalWasteWeekly)
        totalCategoryTarget.append(totalTargetWeekly)
        
        completion(totalTrashCount, totalCategoryTarget)

        
    }
    
    func getTrashDataWeekly(date:String, completion: @escaping (_ totalTrashCount: Int, _ totalTargetCount: Int) -> ()){
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
}

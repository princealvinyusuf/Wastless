//
//  DetailHistoryPresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Raihan on 01/11/20.
//

import UIKit
import CoreData

class DetailHistoryPresenter{
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let trashList: [String] = ["Plastic", "Glass", "Paper", "Metal", "Organic"]
    var listSelectedWaste = [WasteHistory]()
    
    
    func dateChecker(date: Date, type: String, completion: @escaping (_ date : String, _ dateCD: String)->()){
        let dateFormatterDaily = DateFormatter()
        dateFormatterDaily.dateFormat = "EEEE, d MMM yyyy"
        
        let dateFormatterMonthly = DateFormatter()
        dateFormatterMonthly.dateFormat = "MMMM yyyy"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ("dd/MM/yyyy")
        
        let dateForCD = dateFormatter.string(from: date)
        var dateGetter = ""
        
        if type == "daily"{
            dateGetter = dateFormatterDaily.string(from: date)
        }else if type == "weekly"{
            //dateGetter = dateFormatterMonthly.string(from: date)
        }else if type == "monthly"{
            dateGetter = dateFormatterMonthly.string(from: date)
        }
        
        completion(dateGetter, dateForCD)
    }
    
    func loadTrashData(date:String, completion: @escaping (_ trashCount: [Int],_ listTrash: [WasteHistory])->()){
        var trashes = [TrashCD]()
        var totalTrashCount: [Int] = []
        
        
        if let appdelegate = appDelegate{
            for trash in trashList{
                let managedContext = appDelegate!.persistentContainer.viewContext
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
                    if ttrash.count > 0 {
                        addWasteModel(wasteName: String(ttrash.name!), wasteCount: Int(truncatingIfNeeded: ttrash.count))
                    }
                    
                }
                totalTrashCount.append(countOfWaste)
            }
            
            completion(totalTrashCount, listSelectedWaste)
        }
    }
    
    func loadTrashDataMonthly(date:Date, completion: @escaping (_ trashCount: [Int],_ listTrash: [WasteHistory])->()){
        var trashes = [TrashCD]()
        var totalTrashCount: [Int] = []
        
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let month = monthFormatter.string(from: date)
        let year = yearFormatter.string(from: date)
        
        for trash in trashList{ //Trash Type
            var countOfWaste = 0
            for day in 1...31{ //31 days Checker
                let day = String(format: "%02d", day)
                let date = ("\(day)/\(month)/\(year)")
                let managedContext = appDelegate!.persistentContainer.viewContext
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
                
                for ttrash in trashes{
                    
                    countOfWaste += Int(truncatingIfNeeded: ttrash.count)
                    if ttrash.count > 0 { // Check if trash available
                        if listSelectedWaste.contains(where:{$0.waste == ttrash.name}){ // Check if trash Exist or no
                            let trashExist = listSelectedWaste.firstIndex(where: {$0.waste == ttrash.name})
                            listSelectedWaste[trashExist!].count += Int(truncatingIfNeeded: ttrash.count)
                            
                        }else{
                            addWasteModel(wasteName: String(ttrash.name!), wasteCount: Int(truncatingIfNeeded: ttrash.count))

                        }
                    }
                    
                }
                
            }
            totalTrashCount.append(countOfWaste)
        }
        completion(totalTrashCount, listSelectedWaste)
        
    }
    
    func addWasteModel(wasteName: String, wasteCount: Int){
        let wasteAdded = WasteHistory(waste: wasteName, count: wasteCount)
        listSelectedWaste.append(wasteAdded)
    }
    

}

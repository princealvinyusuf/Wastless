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
    
    
    func dateChecker(date: Date, completion: @escaping (_ date : String, _ dateCD: String)->()){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = ("dd/MM/yyyy")
        
        let dateForCD = dateFormatter2.string(from: date)
        let dateGetter = dateFormatter.string(from: date)
        
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
            print(listSelectedWaste)
            completion(totalTrashCount, listSelectedWaste)
        }
    }
    
    func addWasteModel(wasteName: String, wasteCount: Int){
        let wasteAdded = WasteHistory(waste: wasteName, count: wasteCount)
        listSelectedWaste.append(wasteAdded)
    }
    
//    func getTotalWasteWeekly(date: Date, completion: @escaping (_ totalTrash : [Int], _ totalTarget : [Int])->()){
//        let monthFormatter = DateFormatter()
//        let yearFormatter = DateFormatter()
//
//        monthFormatter.dateFormat = "MM"
//        yearFormatter.dateFormat = "yyyy"
//
//
//        let month = monthFormatter.string(from: date)
//        let year = yearFormatter.string(from: date)
//
//
//        var totalWasteWeekly = 0
//        var totalTargetWeekly = 0
//
//
//        //Week 1
//        for i in 1...8{
//            let day = String(format: "%02d", i)
//            let date = ("\(day)/\(month)/\(year)")
//            getTrashDataWeekly(date: date){(totalTrash, totalTarget) in
//                totalWasteWeekly += totalTrash
//                totalTargetWeekly += totalTarget
//            }
//        }
//
//
//        //Week 2
//        for i in 9...16{
//            let day = String(format: "%02d", i)
//            let date = ("\(day)/\(month)/\(year)")
//            getTrashDataWeekly(date: date){(totalTrash, totalTarget) in
//                totalWasteWeekly += totalTrash
//                totalTargetWeekly += totalTarget
//            }
//        }
//
//
//
//        //Week 3
//        for i in 17...24{
//            let day = String(format: "%02d", i)
//            let date = ("\(day)/\(month)/\(year)")
//            getTrashDataWeekly(date: date){(totalTrash, totalTarget) in
//                totalWasteWeekly += totalTrash
//                totalTargetWeekly += totalTarget
//            }
//        }
//
//
//
//        //Week 4
//        for i in 25...31{
//            let day = String(format: "%02d", i)
//            let date = ("\(day)/\(month)/\(year)")
//            getTrashDataWeekly(date: date){(totalTrash, totalTarget) in
//                totalWasteWeekly += totalTrash
//                totalTargetWeekly += totalTarget
//            }
//        }
//
//    }
//
//    func getTrashDataWeekly(date:String, completion: @escaping (_ totalTrashCount: Int) -> ()){
//        var trashes = [TrashCD]()
//        var totalTrashCount: [Int] = []
//        var totalCategoryTarget: [Int] = []
//
//        if let appDelegate = appDelegate {
//            for trash in trashList{
//                totalTrashCount.removeAll()
//                totalCategoryTarget.removeAll()
//                let datePredicate = NSPredicate(format: "date=%@", date)
//
//                //TRASH DATA
//                let managedContext = appDelegate.persistentContainer.viewContext
//                let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
//                trashRequest.predicate = datePredicate
//                do {
//                    try trashes = managedContext.fetch(trashRequest)
//                } catch {
//                    print("Error Data could not be shown")
//                }
//                var countOfWaste = 0
//                for ttrash in trashes{
//                    countOfWaste += Int(truncatingIfNeeded: ttrash.count)
//                }
//
//                completion(countOfWaste)
//
//            }
//        }
//    }
}

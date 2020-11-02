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
    
    
    func dateChecker(date: Date, completion: @escaping (_ date : String, _ dateCD: String)->()){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = ("dd/MM/yyyy")
        
        let dateForCD = dateFormatter2.string(from: date)
        let dateGetter = dateFormatter.string(from: date)
        
        completion(dateGetter, dateForCD)
    }
    
    func loadTrashData(date:String, completion: @escaping (_ trashCount: [Int])->()){
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
                }
                totalTrashCount.append(countOfWaste)
                
            }
            completion(totalTrashCount)
        }
    }
    
    func loadTrashData2(date:String){
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
                
                for ttrash in trashes{
                    //totalTrashCount.append(Int(truncatingIfNeeded: ttrash.count))
                    print(ttrash.name)
                    print(ttrash.count)
                }
                

            }
            print(totalTrashCount)
        }
    }
}

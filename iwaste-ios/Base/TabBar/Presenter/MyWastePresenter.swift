//
//  MyWastePresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 26/10/20.
//

import UIKit
import CoreData

protocol MyWasteDelegate {
    func dataCategoriesSuccess(categories: [CategoryCD])
    func dataCategoriesFail(error: Error)
}

class MyWastePresenter {
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var delegate: MyWasteDelegate?
    
    init(delegate: MyWasteDelegate) {
        self.delegate = delegate
    }
    
    func getDate() -> String{
        //Check today date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ("dd/MM/yyyy")
        let datenow = dateFormatter.string(from: date)
        
        return datenow
    }
    
    func loadCategory() {
        var categories: [CategoryCD]?
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let catRequest: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
            catRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            do {
                try categories = managedContext.fetch(catRequest)
            } catch{
                print("Error Data couldnot be shown")
                delegate?.dataCategoriesFail(error: error)
            }
        }
        
        delegate?.dataCategoriesSuccess(categories: categories!)
    }
    
    func loadDataTrash(categories: [CategoryCD]? ,type: WasteType, completion: @escaping (_ totalOfWaste: Int, _ target: Int, _ progress: Float) -> ()) {
        
        // Get trashes data base on type from core data
        var trashes = [TrashCD]()
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
            
            
           //PREDICATE
            let datePredicate = NSPredicate(format: "date=%@", getDate())
            let typePredicate = NSPredicate(format: "type=%@", type.rawValue)
            trashRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [datePredicate, typePredicate])
            
            trashRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
            do {
                try trashes = managedContext.fetch(trashRequest)
            } catch {
                print("Error Data could not be shown")
            }
        }
        
        //get data of waste on each type of waste
        var countOfWaste = 0
        for trash in trashes {
            countOfWaste += Int(truncatingIfNeeded: trash.count)
        }
        
        // extract exact category from list to get Target of category
        var category = CategoryCD()
        categories?.forEach { (cat) in
            let name = cat.name
            let sliced = name?.dropFirst()
            if sliced! == type.rawValue {
                category = cat
            }
        }
        let targetOfCategory = Int(truncatingIfNeeded: category.target)
        
        // calculate progress for displayed on progress bar
        let progress = Float(countOfWaste)/Float(targetOfCategory)*100
        
        completion(countOfWaste, targetOfCategory, progress)
    }
    
    func totalTrashUsage(categories: [CategoryCD]?, completion: @escaping (_ progress: Float) -> ()){
        var trashes = [TrashCD]()
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
            trashRequest.predicate = NSPredicate(format: "date=%@", self.getDate())
            trashRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
            do {
                try trashes = managedContext.fetch(trashRequest)
            } catch {
                print("Error Data could not be shown")
            }
        }
        
        //get data of waste on each type of waste
        var countOfWaste = 0
        for trash in trashes {
            countOfWaste += Int(truncatingIfNeeded: trash.count)
        }
        
        // Get data of total Target
        var targetOfCategory = 0
        for cat in categories!{
            targetOfCategory += Int(truncatingIfNeeded: cat.target)
        }
        
        //Calculate PRogress for displayed in Wave
        let progress = Float(countOfWaste)/Float(targetOfCategory)
        
        completion(progress)
    }
    
    func getTodayDate(completion: @escaping (_ strDate: String) -> ()) {
        let userCalendar = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        
        completion(formatter.string(from: userCalendar))
    }
    
    func checkTodayData() -> Bool{
        
        var isempty:Bool = true
        
        //check core data
        var trashes = [TrashCD]()
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
            trashRequest.predicate = NSPredicate(format: "date=%@", self.getDate())
            trashRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
            do {
                try trashes = managedContext.fetch(trashRequest)
            } catch {
                print("Error Data could not be shown")
            }
            
            //Check if coredata empty or no
            if(trashes.isEmpty){
                isempty = false

            }else{
                isempty = true
            }
        }
        return isempty
    }
}

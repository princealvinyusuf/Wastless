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
            trashRequest.predicate = NSPredicate(format: "type=%@", type.rawValue)
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
    
    func getTodayDate(completion: @escaping (_ strDate: String) -> ()) {
        let userCalendar = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        
        completion(formatter.string(from: userCalendar))
    }
}

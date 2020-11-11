//
//  CurrentWastePresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 27/10/20.
//

import UIKit
import CoreData

protocol CurrentWasteDelegate {
    func loadCategoriesSuccess(cat: [CategoryCD])
    func loadCategoriesFail(err: Error)
    
    func loadAllWaste(data: [TrashData])
}

class CurrentWastePresenter {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var delegate: CurrentWasteDelegate?
    
    init(delegate: CurrentWasteDelegate) {
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
    
    func loadCategories() {
        var categories: [CategoryCD]?
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let catRequest: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
            catRequest.predicate = NSPredicate(format: "date=%@", getDate())
            catRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            do {
                try categories = managedContext.fetch(catRequest)
            } catch let err {
                delegate?.loadCategoriesFail(err: err)
            }
        }
        
        delegate?.loadCategoriesSuccess(cat: categories!)
    }
    
    private func loadDataTrash(type: WasteType) -> TrashData {
        var trashes = [TrashCD]()
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
            
            let datePredicate = NSPredicate(format: "date=%@", getDate())
            let typePredicate = NSPredicate(format: "type=%@", type.rawValue)
            trashRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [datePredicate, typePredicate])
            trashRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
            
            do {
                try trashes = managedContext.fetch(trashRequest)
            } catch {
                print("error load data trashes: ", error.localizedDescription)
            }
        }
        
        let trashData = TrashData(trashname: type.rawValue, trash: trashes)
        
        print("ttrashh: ", trashes)
        
        let dateFormat = "dd/MM/yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        for trash in trashes {
            let datee = dateFormatter.date(from: trash.date!)
            print("weekNum: ", datee!.weekOfMonth)
        }
        return trashData
    }
    
    func loadDataAllWaste() {
        
        let dataTrashPlastic = loadDataTrash(type: .plastic)
        let dataTrashGlass = loadDataTrash(type: .glass)
        let dataTrashPaper = loadDataTrash(type: .paper)
        let dataTrashMetal = loadDataTrash(type: .metal)
        let dataTrashOrganic = loadDataTrash(type: .organic)
        
        delegate?.loadAllWaste(data: [dataTrashPlastic, dataTrashGlass, dataTrashPaper, dataTrashMetal, dataTrashOrganic])
    }
}

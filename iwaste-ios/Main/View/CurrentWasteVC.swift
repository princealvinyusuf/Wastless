//
//  CurrentWasteVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 14/10/20.
//

import UIKit
import LinearProgressView
import CoreData

//class CurrentWasteVC: UIViewController {
//
//    @IBOutlet weak var linearProgressPlastics: LinearProgressView!
//    @IBOutlet weak var linearProgressMetals: LinearProgressView!
//    @IBOutlet weak var linearProgressGlass: LinearProgressView!
//    @IBOutlet weak var linearProgressPapers: LinearProgressView!
//    @IBOutlet weak var linearProgressOrganic: LinearProgressView!
//
//
//    @IBAction func btnCancel(_ sender: UIBarButtonItem) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        linearProgressPlastics.animationDuration = 0.5
//        linearProgressPlastics.barColor = #colorLiteral(red: 0.462745098, green: 0.7529411765, blue: 0.8509803922, alpha: 1)
//        linearProgressPlastics.trackColor = #colorLiteral(red: 0, green: 0.5076726079, blue: 0.6999972463, alpha: 1)
//
//        linearProgressMetals.animationDuration = 0.5
//        linearProgressMetals.barColor = #colorLiteral(red: 0.9647058824, green: 0.4745098039, blue: 0.4901960784, alpha: 1)
//        linearProgressMetals.trackColor = #colorLiteral(red: 0.8784641623, green: 0, blue: 0, alpha: 1)
//
//        linearProgressGlass.animationDuration = 0.5
//        linearProgressGlass.barColor = #colorLiteral(red: 0.7490196078, green: 0.5215686275, blue: 0.968627451, alpha: 1)
//        linearProgressGlass.trackColor = #colorLiteral(red: 0.470867455, green: 0, blue: 0.9179152846, alpha: 1)
//
//        linearProgressPapers.animationDuration = 0.5
//        linearProgressPapers.barColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.4549019608, alpha: 1)
//        linearProgressPapers.trackColor = #colorLiteral(red: 1, green: 0.6840727925, blue: 0, alpha: 1)
//
//        linearProgressOrganic.animationDuration = 0.5
//        linearProgressOrganic.barColor = #colorLiteral(red: 0.4352941176, green: 0.7921568627, blue: 0.4941176471, alpha: 1)
//        linearProgressOrganic.trackColor = #colorLiteral(red: 0, green: 0.5792904496, blue: 0, alpha: 1)
//
//        updateLinearProgress()
//
//    }
//
//    @objc
//    func updateLinearProgress() {
//        linearProgressPlastics.setProgress(20, animated: true)
//        linearProgressPlastics.barInset = CGFloat(4)
//        linearProgressPlastics.isCornersRounded = true
//
//        linearProgressMetals.setProgress(40, animated: true)
//        linearProgressMetals.barInset = CGFloat(4)
//        linearProgressMetals.isCornersRounded = true
//
//        linearProgressGlass.setProgress(60, animated: true)
//        linearProgressGlass.barInset = CGFloat(4)
//        linearProgressGlass.isCornersRounded = true
//
//        linearProgressPapers.setProgress(35, animated: true)
//        linearProgressPapers.barInset = CGFloat(4)
//        linearProgressPapers.isCornersRounded = true
//
//        linearProgressOrganic.setProgress(85, animated: true)
//        linearProgressOrganic.barInset = CGFloat(4)
//        linearProgressOrganic.isCornersRounded = true
//    }
//}

class CurrentWasteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //Core Data
    var managedObjectContext: NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = appDelegate?.persistentContainer.viewContext
        loadDataCat()
        loadDataTrash()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CurrentViewCell", bundle: self.nibBundle), forCellReuseIdentifier: "currentViewCell")

    }

    @IBAction func btnCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadDataCat(){
        let catRequest: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
        catRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do{
            try category = managedObjectContext!.fetch(catRequest)
        }catch{
            print("Error Data couldnot be shown")
        }
    }
    
    func loadDataTrash(){
        let trashPlasticRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        let trashGlassRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        let trashPaperRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        let trashMetalRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        let trashOrganicRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        
        trashPlasticRequest.predicate = NSPredicate(format: "type=%@", "Plastic")
        trashGlassRequest.predicate = NSPredicate(format: "type=%@", "Glass")
        trashPaperRequest.predicate = NSPredicate(format: "type=%@", "Paper")
        trashMetalRequest.predicate = NSPredicate(format: "type=%@", "Metal")
        trashOrganicRequest.predicate = NSPredicate(format: "type=%@", "Organic")
        
        trashPlasticRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        trashGlassRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        trashPaperRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        trashMetalRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        trashOrganicRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        
        do{
            try trashPlastic = managedObjectContext!.fetch(trashPlasticRequest)
            try trashGlass = managedObjectContext!.fetch(trashGlassRequest)
            try trashPaper = managedObjectContext!.fetch(trashPaperRequest)
            try trashMetal = managedObjectContext!.fetch(trashMetalRequest)
            try trashOrganic = managedObjectContext!.fetch(trashOrganicRequest)
        }catch{
            print("Error Data couldnot be shown")
        }
    }
}

extension CurrentWasteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataWaste.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currentViewCell") as? CurrentViewCell else {return UITableViewCell()}
        
        cell.configureCell(modelWaste: dataWaste[indexPath.row], indexPath.row, trashData: trashDataCD[indexPath.row])
        return cell
    }
}

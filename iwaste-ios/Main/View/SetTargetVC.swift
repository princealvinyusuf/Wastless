//
//  SetTargetVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 18/10/20.
//

import UIKit
import CoreData

class SetTargetVC: UIViewController {

    //UI
    @IBOutlet weak var plasticTF: UITextField!
    @IBOutlet weak var glassTF: UITextField!
    @IBOutlet weak var paperTF: UITextField!
    @IBOutlet weak var metalTF: UITextField!
    @IBOutlet weak var organicTF: UITextField!
    @IBAction func btnDone(_ sender: UIBarButtonItem) {
        // set to true so target screen wont show up after target is set
        UserDefaultService.instance.isTargetSet = true
        
        self.dismiss(animated: true, completion: nil)
    }
    //CoreData
    var delegate: WasteTargetDelegate?
    
    var categoy = [CategoryCD]()
    var managedObjectContext: NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = appDelegate?.persistentContainer.viewContext

    }
    @IBAction func doneTappedButton(_ sender: Any) {
        if plasticTF.text!.isEmpty || glassTF.text!.isEmpty || paperTF.text!.isEmpty || metalTF.text!.isEmpty || organicTF.text!.isEmpty{
            print("Input The Data")
        }else{
            addData()
            addDataTrash()
            UserDefaultService.instance.isTargetSet = true
            
            self.dismiss(animated: true) {
                self.delegate?.updateUI()
            }
        }
        
    }
    
    func addData(){
        let catEntity = NSEntityDescription.entity(forEntityName: "CategoryCD", in: managedObjectContext!)
        let plasticCat = NSManagedObject(entity: catEntity!, insertInto: managedObjectContext!)
        let glassCat = NSManagedObject(entity: catEntity!, insertInto: managedObjectContext!)
        let paperCat = NSManagedObject(entity: catEntity!, insertInto: managedObjectContext!)
        let metalCat = NSManagedObject(entity: catEntity!, insertInto: managedObjectContext!)
        let organicCat = NSManagedObject(entity: catEntity!, insertInto: managedObjectContext!)
        
        //Plastic Category
        plasticCat.setValue(Date(), forKey: "date")
        if let count = Int(plasticTF.text!){
            plasticCat.setValue(count, forKey: "target")
        }
        plasticCat.setValue("APlastic", forKey: "name")
        
        //Glass Category
        glassCat.setValue(Date(), forKey: "date")
        if let count = Int(glassTF.text!){
            glassCat.setValue(count, forKey: "target")
        }
        glassCat.setValue("BGlass", forKey: "name")
        
        //Paper Category
        paperCat.setValue(Date(), forKey: "date")
        if let count = Int(paperTF.text!){
            paperCat.setValue(count, forKey: "target")
        }
        paperCat.setValue("CPaper", forKey: "name")
        
        //Metal CAtegory
        metalCat.setValue(Date(), forKey: "date")
        if let count = Int(metalTF.text!){
            metalCat.setValue(count, forKey: "target")
        }
        metalCat.setValue("DMetal", forKey: "name")
        
        //Organic Category
        organicCat.setValue(Date(), forKey: "date")
        if let count = Int(organicTF.text!){
            organicCat.setValue(count, forKey: "target")
        }
        organicCat.setValue("EOrganic", forKey: "name")
        
        do {
            try managedObjectContext?.save()
            print("saved \(plasticCat)")
            print("saved \(glassCat)")
            print("saved \(paperCat)")
            print("saved \(metalCat)")
            print("saved \(organicCat)")
        }catch let error as NSError{
            print("Couldnot save \(error)")
        }
    
        }
    
    func addDataTrash(){
            let trashEntity = NSEntityDescription.entity(forEntityName: "TrashCD", in: managedObjectContext!)
            
            for i in 0...4{
                for n in 0...5{
                    let newTrash = NSManagedObject(entity: trashEntity!, insertInto: managedObjectContext!)
                    
                    newTrash.setValue(Date(), forKey: "date")
                    newTrash.setValue(dataWaste[i].categoryName, forKey: "type")
                    newTrash.setValue(dataWaste[i].waste[n].wasteName, forKey: "name")
                    newTrash.setValue(0, forKey: "count")
                    do{
                        try  managedObjectContext?.save()
                    }catch let error as NSError{
                        print("Couldnt Save Core Data")
                    }
                }
            }
        }
}

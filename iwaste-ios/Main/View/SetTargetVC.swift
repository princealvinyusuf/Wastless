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
    @IBOutlet weak var txtDate: UILabel!
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var presenter: SetTargetPresenter?
    var delegate: WasteTargetDelegate?
    
    var category = [CategoryCD]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SetTargetPresenter()
        presenter?.showDate(){(date) in
            self.txtDate.text = date
        }
        self.hideKeyboard()
        
    }
    
    
    
    @IBAction func doneTappedButton(_ sender: Any) {
        if plasticTF.text!.isEmpty || glassTF.text!.isEmpty || paperTF.text!.isEmpty || metalTF.text!.isEmpty || organicTF.text!.isEmpty{

        }else{
            addData()
            UserDefaultService.instance.isTargetSet = true
            
            let cats = BadgeService.loadCategories()
            print("categories: ", cats.count)
            self.dismiss(animated: true) {
                self.delegate?.updateUI()
                self.delegate?.checkTargetSet()
            }
        }
        
    }
    
    func addData(){
        //Plastic Category
        if let count = Int(plasticTF.text!){
            presenter?.addCategoryTarget(name: "APlastic", target: count)
        }
        
        //Glass Category
        if let count = Int(glassTF.text!){
            presenter?.addCategoryTarget(name: "BGlass", target: count)
        }
        
        //Paper Category
        if let count = Int(paperTF.text!){
            presenter?.addCategoryTarget(name: "CPaper", target: count)
        }
        
        //Metal CAtegory
        if let count = Int(metalTF.text!){
            presenter?.addCategoryTarget(name: "DMetal", target: count)
        }
        
        //Organic Category
        if let count = Int(organicTF.text!){
            presenter?.addCategoryTarget(name: "EOrganic", target: count)
        }
        
        presenter?.addDataTrash()
    }
}

extension UIViewController {
    func hideKeyboard(){
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

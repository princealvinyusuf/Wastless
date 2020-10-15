//
//  AddNewWasteVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 14/10/20.
//

import UIKit

class AddNewWasteVC: UIViewController {

    @IBOutlet weak var navHeader: UINavigationBar!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var collectionWaste: UICollectionView!
    @IBOutlet weak var inputWasteField: UITextField!
    @IBOutlet weak var lblNumTrash: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnAddWaste: UIButton!
    @IBOutlet weak var tableWasteAdded: UITableView!
    
    var selectedCategory: ModelWaste? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionWaste.delegate = self
        collectionWaste.dataSource = self
        collectionWaste.register(UINib(nibName: "HorizontalModalListView", bundle: self.nibBundle), forCellWithReuseIdentifier: "horizontalModalListView")
        
        tableWasteAdded.delegate = self
        tableWasteAdded.dataSource = self
        tableWasteAdded.register(UINib(nibName: "WasteViewCell", bundle: self.nibBundle), forCellReuseIdentifier: "wasteViewCell")
        
        lblNumTrash.layer.cornerRadius = 11.0
        lblNumTrash.layer.borderWidth = 2
        lblNumTrash.layer.borderColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        lblNumTrash.textColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        
        btnPlus.tintColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        btnMinus.tintColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        
        btnAddWaste.layer.cornerRadius = 10
        btnAddWaste.backgroundColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        btnAddWaste.titleLabel?.tintColor = UIColor.systemBackground
        
        btnDone.tintColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        btnCancel.tintColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)]
        navHeader.titleTextAttributes = textAttributes
        navHeader.topItem?.title = selectedCategory?.categoryName

    }

    @IBAction func btnPlusMinusClicked(_ sender: UIButton) {
        var currentNum = Int(lblNumTrash.text!)!
        if sender.tag == 0 {
            currentNum += 1
            lblNumTrash.text = String(describing: currentNum)
        } else {
            currentNum -= 1
            lblNumTrash.text = String(describing: currentNum)
        }
    }
    
    @IBAction func btnAddWasteClicked(_ sender: Any) {
        print("clicked")
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddNewWasteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (selectedCategory?.waste.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalModalListView", for: indexPath) as? HorizontalModalListView else {return UICollectionViewCell()}
        cell.configureCell(waste: (selectedCategory?.waste[indexPath.row])!)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//            return CGSize(width: view.frame.width/5, height: view.frame.height)
//    }
}

extension AddNewWasteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wasteViewCell") else {return UITableViewCell()}
        
        return cell
    }
    
}

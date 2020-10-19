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
    var listWasteAdded = [WasteAdded]()
    var currentNum = 1
    var selectedWaste: Waste?
    
    var presenter: AddNewWastePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = AddNewWastePresenter(delegate: self)
        
        collectionWaste.delegate = self
        collectionWaste.dataSource = self
        collectionWaste.register(UINib(nibName: "HorizontalModalListView", bundle: self.nibBundle), forCellWithReuseIdentifier: "horizontalModalListView")
        
        tableWasteAdded.delegate = self
        tableWasteAdded.dataSource = self
        tableWasteAdded.register(UINib(nibName: "WasteViewCell", bundle: self.nibBundle), forCellReuseIdentifier: "wasteViewCell")
        
        lblNumTrash.layer.cornerRadius = 11.0
        lblNumTrash.layer.borderWidth = 2
        lblNumTrash.layer.borderColor = K.Color.primaryColor.cgColor
        lblNumTrash.textColor = K.Color.primaryColor
        
        btnPlus.tintColor = K.Color.primaryColor
        btnMinus.tintColor = K.Color.primaryColor
        
        btnAddWaste.layer.cornerRadius = 10
        btnAddWaste.backgroundColor = K.Color.primaryColor
        btnAddWaste.titleLabel?.tintColor = UIColor.white
        
        btnDone.tintColor = K.Color.primaryColor
        btnCancel.tintColor = K.Color.primaryColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:K.Color.primaryColor]
        navHeader.titleTextAttributes = textAttributes
        navHeader.topItem?.title = selectedCategory?.categoryName
        
    }
    
    @IBAction func btnPlusMinusClicked(_ sender: UIButton) {
        currentNum = Int(lblNumTrash.text!)!
        if sender.tag == 0 {
            currentNum += 1
            lblNumTrash.text = String(describing: currentNum)
        } else {
            currentNum -= 1
            lblNumTrash.text = String(describing: currentNum)
        }
    }
    
    @IBAction func btnAddWasteClicked(_ sender: Any) {
        inputWasteField.resignFirstResponder()
        if currentNum > 0 {
            if inputWasteField.text != "" {
                selectedWaste = Waste(wasteName: inputWasteField.text!, wasteImg: UIImage(named: "inputStraw")!)
            }
            
            if let wasteSelected = selectedWaste {
                presenter?.addWaste(selectedWaste: wasteSelected, numOfWaste: currentNum)
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedWaste = selectedCategory?.waste[indexPath.row]
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    //            return CGSize(width: view.frame.width/5, height: view.frame.height)
    //    }
}

extension AddNewWasteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWasteAdded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wasteViewCell") as? WasteViewCell else {return UITableViewCell()}
        cell.configureCell(wasteAdded: listWasteAdded[indexPath.row])
        
        return cell
    }
    
}

extension AddNewWasteVC: AddNewWasteDelegate {
    func addWasteSuccess(wasteAdded: [WasteAdded]) {
        // Reset State
        currentNum = 1
        lblNumTrash.text = "1"
        inputWasteField.text = ""
        selectedWaste = nil
        
        // reload table view to display newest data
        listWasteAdded = wasteAdded
        tableWasteAdded.reloadData()

        // deselect all item on collection view
        let selectedItems = collectionWaste.indexPathsForSelectedItems
        selectedItems?.forEach({ (index) in
            collectionWaste.deselectItem(at: index, animated: true)
        })
    }
    
    func addWasteError(err: Error) {
        // TODO Later
    }
    
    
}

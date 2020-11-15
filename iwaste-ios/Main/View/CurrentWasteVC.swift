//
//  CurrentWasteVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 14/10/20.
//

import UIKit
import LinearProgressView

class CurrentWasteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: CurrentWastePresenter?
    
    var dataTrashes = [TrashData]()
    var categories = [CategoryCD]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CurrentWastePresenter(delegate: self)
        presenter?.loadCategories()
        presenter?.loadDataAllWaste()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CurrentViewCell", bundle: self.nibBundle), forCellReuseIdentifier: "currentViewCell")
    }

    @IBAction func btnCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CurrentWasteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataWaste.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currentViewCell") as? CurrentViewCell else {return UITableViewCell()}
        
        let target = Int(truncatingIfNeeded: categories[indexPath.row].target)
        cell.configureCell(modelWaste: dataWaste[indexPath.row], target: target, indexPath.row, trashData: dataTrashes[indexPath.row])
        return cell
    }
}

extension CurrentWasteVC: CurrentWasteDelegate {
    func loadCategoriesSuccess(cat: [CategoryCD]) {
        self.categories.removeAll()
        self.categories = cat
    }
    
    func loadCategoriesFail(err: Error) {
        print("error load categories current waste: ", err)
    }
    
    func loadAllWaste(data: [TrashData]) {
        self.dataTrashes.removeAll()
        self.dataTrashes = data
    }
    
    
}

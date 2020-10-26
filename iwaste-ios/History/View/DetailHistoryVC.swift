//
//  DetailHistoryVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 24/10/20.
//

import UIKit

class DetailHistoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imgPlastic: UIImageView!
    @IBOutlet weak var imgGlass: UIImageView!
    @IBOutlet weak var imgPaper: UIImageView!
    @IBOutlet weak var imgMetal: UIImageView!
    @IBOutlet weak var imgOrganic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailHistoryCell", bundle: self.nibBundle), forCellReuseIdentifier: "detailHistoryCell")
        
        imgPlastic.image = UIImage(named: "trashbinplastic")
        imgGlass.image = UIImage(named: "trashbinglass")
        imgPaper.image = UIImage(named: "trashbinpaper")
        imgMetal.image = UIImage(named: "trashbinmetal")
        imgOrganic.image = UIImage(named: "trashbinorganic")
        
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailHistoryCell") as? DetailHistoryCell else {return UITableViewCell()}
        
        return cell
    }
    
    
}

//
//  FirstSegmentedVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import UIKit

class FirstSegmentedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let identifier: String = "tableCell"
    var challenge = Challenge.createChallenge()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

}

extension FirstSegmentedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableCell {
            cell.configurateTheCell(challenge[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}


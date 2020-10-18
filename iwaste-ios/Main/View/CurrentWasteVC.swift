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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currentViewCell") as? CurrentViewCell else {return UITableViewCell()}
        
        return cell
    }
    
}

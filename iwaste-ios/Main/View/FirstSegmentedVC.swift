//
//  FirstSegmentedVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import UIKit
import BonsaiController

class FirstSegmentedVC: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var tableView: UITableView!
    let identifier: String = "tableCell"
    var challenge = Challenge.createChallenge()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailChallenge",
            let indexPath = tableView?.indexPathForSelectedRow,
            let destinationViewController: DetailChallengeVC = segue.destination as? DetailChallengeVC {
            destinationViewController.challenge = challenge[indexPath.row]
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
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

extension FirstSegmentedVC: BonsaiControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    
       return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
        
        
    }
}



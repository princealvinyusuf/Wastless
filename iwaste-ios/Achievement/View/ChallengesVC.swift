//
//  FirstSegmentedVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import UIKit
import BonsaiController

protocol ChallengesDelegate {
    func refreshView()
    func upgradeLevel()
}

class ChallengesVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let identifier: String = "tableCell"
    var challenge = Challenge.createChallenge()
    
    var udService = UserDefaultService.instance
    
    var delegate: AchievementDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ChallengesVC: viewWillAppear")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailChallenge",
           let indexPath = tableView?.indexPathForSelectedRow,
           let destinationViewController: DetailChallengeVC = segue.destination as? DetailChallengeVC {
            destinationViewController.challenge = challenge[indexPath.row]
            destinationViewController.position = indexPath.row
            destinationViewController.delegate = self
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    
}

extension ChallengesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableCell {
            let selectedChallenge = challenge[indexPath.row]
            
            cell.configurateTheCell(selectedChallenge)
            
            for num in udService.achievementArray {
                if indexPath.row == num {
                    cell.btnCheckBox.setImage(UIImage(named:"Checkmark"), for: .normal)
                    cell.subView.backgroundColor = K.Color.primarySoft
                }
            }
            
            let dataLevel = Level(rawValue: udService.level) ?? .novice
            if selectedChallenge.level == dataLevel {
                cell.imgLock.isHidden = true
                cell.isUserInteractionEnabled = true

            } else {
                cell.imgLock.isHidden = false
                cell.isUserInteractionEnabled = false
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

extension ChallengesVC: BonsaiControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
    }
}

extension ChallengesVC: ChallengesDelegate {
    func upgradeLevel() {
        self.delegate?.upgradeLevel()
        print("hhhhhh: ", udService.level)
        refreshView()
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Congratulations!", message: "Your level is up", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func refreshView() {
        self.delegate?.refreshView()
        self.tableView.reloadData()
    }
}

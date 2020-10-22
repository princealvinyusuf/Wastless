//
//  DetailChallengeVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 21/10/20.
//

import UIKit

class DetailChallengeVC: UIViewController {

    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var subView: UIView!
    
    @IBAction func btnDone(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var challenge: Challenge?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let challenge = challenge {
            titleLabel.text = "Challenge: " + challenge.title
            challengeImageView.image = UIImage(named: challenge.image)
            contentTextView.text = challenge.challengeDetail
        }
        
        subView.layer.cornerRadius = 10
    }
}

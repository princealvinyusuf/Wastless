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
    
    
    var challenge: Challenge?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let challenge = challenge {
            titleLabel.text = "Challenge: " + challenge.title
            challengeImageView.image = UIImage(named: challenge.image)
            contentTextView.text = challenge.challengeDetail
        }
        
        subViewConfigure()
    }
    
    func subViewConfigure() {
        subView.layer.cornerRadius = 10
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.5
        subView.layer.shadowOffset = CGSize(width: 0, height: 0)
        subView.layer.shadowRadius = 25.0
    }

}

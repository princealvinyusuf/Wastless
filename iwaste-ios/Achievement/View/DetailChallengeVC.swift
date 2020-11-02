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
    @IBOutlet weak var btnDoneTheChallenge: UIButton!
    
    var challenge: Challenge?
    var position: Int?

    var presenter: DetailChallengePresenter?
    var delegate: ChallengesDelegate?
    
    var udService = UserDefaultService.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailChallengePresenter(delegate: self)
        
        if let challenge = challenge {
            titleLabel.text = "Challenge: " + challenge.title
            challengeImageView.image = UIImage(named: challenge.image)
            contentTextView.text = challenge.challengeDetail
        }
        
        subView.layer.cornerRadius = 10
        
        for ach in udService.achievementArray {
            if ach == position {
                btnDoneTheChallenge.isHidden = true
            }
        }
    }
    
    @IBAction func btnDone(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneTheChallengeTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "DONE THE CHALLENGE?", message: "Are you sure done the challenge", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.presenter?.doneChallenge(at: self.position!)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailChallengeVC: DetailChallengeDelegate {
    func upgradeLevel(bool: Bool) {
        if bool {
            self.delegate?.upgradeLevel()
        }

        delegate?.refreshView()
        self.dismiss(animated: true, completion: nil)
    }
}

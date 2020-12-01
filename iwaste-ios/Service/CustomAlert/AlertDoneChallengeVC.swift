//
//  AlertDoneChallengeVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/11/20.
//

import UIKit

protocol AlertDoneDelegate {
    func doneChallenge()
}

class AlertDoneChallengeVC: UIViewController {

    @IBOutlet weak var btnDone: UIButton!
    
    var delegate: AlertDoneDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnDone.layer.cornerRadius = btnDone.frame.height/2
    }
    
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneTapped(_ sender: UIButton) {
        delegate?.doneChallenge()
        self.dismiss(animated: true, completion: nil)
    }
    
}

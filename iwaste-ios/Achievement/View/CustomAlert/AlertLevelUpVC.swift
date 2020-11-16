//
//  AlertLevelUpVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 03/11/20.
//

import UIKit

class AlertLevelUpVC: UIViewController {

    @IBOutlet weak var imgLevelUp: UIImageView!
    @IBOutlet weak var lblLevelUp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataBadge = BadgeDataFunction.retrieveAllBadgeData()
        if dataBadge.count > 0 {
            let badgeOrder = dataBadge.last?.num
            let badgeForDisplay = Badges.createBadges()[badgeOrder!]
            imgLevelUp.image = badgeForDisplay.image
            lblLevelUp.text = NSLocalizedString("alert_levelup", comment: "Level Up :") + "\(badgeForDisplay.title)"
        }
    }
    
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

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
        
        let level = Level(rawValue: UserDefaultService.instance.level)
        let currentData = getDataLevel(level: level ?? .novice)
        
        imgLevelUp.image = currentData.image
        lblLevelUp.text = NSLocalizedString("alert_levelup", comment: "Level Up :") + "\(currentData.name)"
    }
    
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

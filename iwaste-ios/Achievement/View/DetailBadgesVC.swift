//
//  DetailBadgesVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 21/10/20.
//

import UIKit

class DetailBadgesVC: UIViewController {
    
    @IBOutlet weak var medalsImageView: UIImageView!
    @IBOutlet weak var dateObtainedLabel: UILabel!
    @IBOutlet weak var requirementLabel: UILabel!
    
    var pos: Int?
    var badge: Badges?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let medals = BadgesVC.globalVariable.medals
//
//        if medals == "DayMedals" {
//            medalsImageView.image = UIImage(named: "badges1")
//            dateObtainedLabel.text = "15 December 2020"
//            requirementLabel.text = "You will earn this medal if you keep your trash bin lower than 50 trash in a week."
//        }
//
//        if medals == "WeekMedals" {
//            medalsImageView.image = UIImage(named: "badges2")
//            dateObtainedLabel.text = "16 December 2020"
//            requirementLabel.text = "You will earn this medal if you keep your trash bin lower than 50 trash in a week."
//        }
//
//        if medals == "MonthMedals" {
//            medalsImageView.image = UIImage(named: "badges3")
//            dateObtainedLabel.text = "17 December 2020"
//            requirementLabel.text = "You will earn this medal if you keep your trash bin lower than 50 trash in a week."
//        }
//
//        if medals == "YearMedals" {
//            medalsImageView.image = UIImage(named: "badges4")
//            dateObtainedLabel.text = "18 December 2020"
//            requirementLabel.text = "You will earn this medal if you keep your trash bin lower than 50 trash in a week."
//        }
//
        
    }

}

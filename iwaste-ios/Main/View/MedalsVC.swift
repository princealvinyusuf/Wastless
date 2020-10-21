//
//  MedalsVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 21/10/20.
//

import UIKit

class MedalsVC: UIViewController {
    
    
    @IBOutlet weak var medalsImageView: UIImageView!
    @IBOutlet weak var badgesName: UILabel!
    @IBOutlet weak var dateObtainedLabel: UILabel!
    @IBOutlet weak var requirementLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let medals = SecondSegmentedVC.globalVariable.medals
        
        if medals == "DayMedals" {
            medalsImageView.image = UIImage(named: "inputStraw")
            badgesName.text = "Perfect Day"
            dateObtainedLabel.text = "18 December 2020"
            requirementLabel.text = "Lorem Ipsum aque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."
        }
    }

}

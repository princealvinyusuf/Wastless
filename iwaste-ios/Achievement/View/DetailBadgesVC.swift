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
    
    let udService = UserDefaultService.instance
    override func viewDidLoad() {
        super.viewDidLoad()

        let header1 = "You will earn this medal if you keep your trash bin lower than " + "\(String(describing: badge!.missionBin))"
        let header2 = "You've earned this medal for keeping your trash bin lower than " + "\(String(describing: badge!.missionBin))"
        
        let footer = " in a week."

        if BadgeService.isContain(num: pos!) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            
            BadgeService.timesOfAchieve(num: pos!) { (numOfTimes, mostRecent) in
                let stringDate = dateFormatter.string(from: mostRecent)
                self.dateObtainedLabel.text = stringDate
            }
            
            medalsImageView.image = badge?.image
            requirementLabel.text = header2 + footer
        } else {
            requirementLabel.text = header1 + footer
            dateObtainedLabel.text = badge?.title
            medalsImageView.image = UIImage(named: "blankBadges")!
        }
    }
    
    @IBAction func btnDoneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

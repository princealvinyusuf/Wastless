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

        let arrayDateObtained = udService.badgeObtainedDateArray
        
        if pos! <= arrayDateObtained.count-1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let stringDate = dateFormatter.string(from: arrayDateObtained[pos!])
            dateObtainedLabel.text = stringDate
            
            medalsImageView.image = badge?.image
        } else {
            dateObtainedLabel.text = badge?.title
            medalsImageView.image = UIImage(named: "blankBadges")!
        }
        
        requirementLabel.text = badge?.title
        
        let header = "You will earn this medal if you keep your trash bin lower than \(String(describing: badge!.missionBin))"
        var center = " and finish challenge "
        let footer = " in a week."
        
        if !(badge?.missionChallenge.isEmpty)! {
            center = center + "\(String(describing: badge!.missionChallenge.map{"\($0+1)"}.joined(separator: " and ")))"
            
            requirementLabel.text = header + center + footer
        } else {
            requirementLabel.text = header + footer
        }
        
    }
    
    @IBAction func btnDoneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

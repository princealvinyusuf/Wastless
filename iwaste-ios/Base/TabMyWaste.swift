//
//  TabMyWaste.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 10/10/20.
//

import UIKit
import LinearProgressView

class TabMyWaste: UIViewController {

    @IBOutlet weak var linearProgressPlastics: LinearProgressView!
    @IBOutlet weak var linearProgressMetals: LinearProgressView!
    @IBOutlet weak var linearProgressGlass: LinearProgressView!
    @IBOutlet weak var linearProgressPapers: LinearProgressView!
    @IBOutlet weak var linearProgressOrganic: LinearProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linearProgressPlastics.animationDuration = 0.5
        linearProgressPlastics.barColor = #colorLiteral(red: 0.4632664323, green: 0.7548244596, blue: 0.8504111171, alpha: 1)
        linearProgressPlastics.trackColor = #colorLiteral(red: 0, green: 0.5076726079, blue: 0.6999972463, alpha: 1)
        
        linearProgressMetals.animationDuration = 0.5
        linearProgressMetals.barColor = #colorLiteral(red: 0.9633008838, green: 0.4755309224, blue: 0.4895489812, alpha: 1)
        linearProgressMetals.trackColor = #colorLiteral(red: 0.8784641623, green: 0, blue: 0, alpha: 1)
        
        linearProgressGlass.animationDuration = 0.5
        linearProgressGlass.barColor = #colorLiteral(red: 0.7479692101, green: 0.5221053958, blue: 0.9678519368, alpha: 1)
        linearProgressGlass.trackColor = #colorLiteral(red: 0.470867455, green: 0, blue: 0.9179152846, alpha: 1)
        
        linearProgressPapers.animationDuration = 0.5
        linearProgressPapers.barColor = #colorLiteral(red: 1, green: 0.840634346, blue: 0.4565974474, alpha: 1)
        linearProgressPapers.trackColor = #colorLiteral(red: 1, green: 0.6840727925, blue: 0, alpha: 1)
        
        linearProgressOrganic.animationDuration = 0.5
        linearProgressOrganic.barColor = #colorLiteral(red: 0.4335449338, green: 0.7922176719, blue: 0.4929479361, alpha: 1)
        linearProgressOrganic.trackColor = #colorLiteral(red: 0, green: 0.5792904496, blue: 0, alpha: 1)
        
        updateLinearProgress()
    }
    
    @objc
    func updateLinearProgress() {
        linearProgressPlastics.setProgress(20, animated: true)
        linearProgressPlastics.barInset = CGFloat(4)
        linearProgressPlastics.isCornersRounded = true
        
        linearProgressMetals.setProgress(40, animated: true)
        linearProgressMetals.barInset = CGFloat(4)
        linearProgressMetals.isCornersRounded = true
        
        linearProgressGlass.setProgress(60, animated: true)
        linearProgressGlass.barInset = CGFloat(4)
        linearProgressGlass.isCornersRounded = true
        
        linearProgressPapers.setProgress(35, animated: true)
        linearProgressPapers.barInset = CGFloat(4)
        linearProgressPapers.isCornersRounded = true
        
        linearProgressOrganic.setProgress(85, animated: true)
        linearProgressOrganic.barInset = CGFloat(4)
        linearProgressOrganic.isCornersRounded = true
    }
    
    @IBAction func btnAddNewWaste(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addNewWasteVC = storyboard.instantiateViewController(identifier: "AddNewWasteVC") as! AddNewWasteVC
        self.present(addNewWasteVC, animated: true, completion: nil)
    }
    
}


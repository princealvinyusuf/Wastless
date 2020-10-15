//
//  TabMyWasteVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 10/10/20.
//

import UIKit
import LinearProgressView

class TabMyWasteVC: UIViewController {

    @IBOutlet weak var subView: UIView!
    var tapGesture = UITapGestureRecognizer()
    
    @IBOutlet weak var linearProgressPlastics: LinearProgressView!
    @IBOutlet weak var linearProgressMetals: LinearProgressView!
    @IBOutlet weak var linearProgressGlass: LinearProgressView!
    @IBOutlet weak var linearProgressPapers: LinearProgressView!
    @IBOutlet weak var linearProgressOrganic: LinearProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linearProgressPlastics.animationDuration = 0.5
        linearProgressPlastics.barColor = K.Color.colorPlasticSoft
        linearProgressPlastics.trackColor = K.Color.colorPlastic
        
        linearProgressMetals.animationDuration = 0.5
        linearProgressMetals.barColor = K.Color.colorMetalSoft
        linearProgressMetals.trackColor = K.Color.colorMetal
        
        linearProgressGlass.animationDuration = 0.5
        linearProgressGlass.barColor = K.Color.colorGlassSoft
        linearProgressGlass.trackColor = K.Color.colorGlass
        
        linearProgressPapers.animationDuration = 0.5
        linearProgressPapers.barColor = K.Color.colorPaperSoft
        linearProgressPapers.trackColor = K.Color.colorPaper
        
        linearProgressOrganic.animationDuration = 0.5
        linearProgressOrganic.barColor = K.Color.colorOrganicSoft
        linearProgressOrganic.trackColor = K.Color.colorOrganic
        
        updateLinearProgress()
        
        subView.layer.cornerRadius = 10
        subView.layer.shadowColor = UIColor.label.cgColor
        subView.layer.shadowOpacity = 0.5
        subView.layer.shadowOffset = CGSize(width: 0, height: 0)
        subView.layer.shadowRadius = 25.0
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabMyWasteVC.subViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        subView.addGestureRecognizer(tapGesture)
        subView.isUserInteractionEnabled = true
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
    
    @IBAction func btnAddNewWaste(_ sender: UIButton) {
        let category = dataWaste[sender.tag]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addNewWasteVC = storyboard.instantiateViewController(identifier: "AddNewWasteVC") as! AddNewWasteVC
        addNewWasteVC.selectedCategory = category
        self.present(addNewWasteVC, animated: true, completion: nil)
    }
    
    @objc func subViewTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let currentWasteVC = storyboard.instantiateViewController(identifier: "CurrentWasteVC") as! CurrentWasteVC
        self.present(currentWasteVC, animated: true, completion: nil)
    }
}


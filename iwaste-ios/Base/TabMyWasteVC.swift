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
        linearProgressPlastics.barColor = #colorLiteral(red: 0.462745098, green: 0.7529411765, blue: 0.8509803922, alpha: 1)
        linearProgressPlastics.trackColor = #colorLiteral(red: 0, green: 0.5076726079, blue: 0.6999972463, alpha: 1)
        
        linearProgressMetals.animationDuration = 0.5
        linearProgressMetals.barColor = #colorLiteral(red: 0.9647058824, green: 0.4745098039, blue: 0.4901960784, alpha: 1)
        linearProgressMetals.trackColor = #colorLiteral(red: 0.8784641623, green: 0, blue: 0, alpha: 1)
        
        linearProgressGlass.animationDuration = 0.5
        linearProgressGlass.barColor = #colorLiteral(red: 0.7490196078, green: 0.5215686275, blue: 0.968627451, alpha: 1)
        linearProgressGlass.trackColor = #colorLiteral(red: 0.470867455, green: 0, blue: 0.9179152846, alpha: 1)
        
        linearProgressPapers.animationDuration = 0.5
        linearProgressPapers.barColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.4549019608, alpha: 1)
        linearProgressPapers.trackColor = #colorLiteral(red: 1, green: 0.6840727925, blue: 0, alpha: 1)
        
        linearProgressOrganic.animationDuration = 0.5
        linearProgressOrganic.barColor = #colorLiteral(red: 0.4352941176, green: 0.7921568627, blue: 0.4941176471, alpha: 1)
        linearProgressOrganic.trackColor = #colorLiteral(red: 0, green: 0.5792904496, blue: 0, alpha: 1)
        
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


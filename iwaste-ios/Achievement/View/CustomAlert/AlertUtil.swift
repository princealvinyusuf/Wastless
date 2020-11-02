//
//  AlertUtil.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/11/20.
//

import UIKit

class AlertUtil {
    public func instantiateViewController(storyboardName: String, vcIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: vcIdentifier)
    }
    
    func showAlertLevelUp(parentVC: UIViewController) {
        let alertLevelUpVC = self.instantiateViewController(storyboardName: "Alert", vcIdentifier: "AlertLevelUpVC") as! AlertLevelUpVC
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(alertLevelUpVC, forKey: "contentViewController")
        
        parentVC.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertDoneChallenge(parentVC: UIViewController, delegate: AlertDoneDelegate) {
        let alertDoneChallengeVC = self.instantiateViewController(storyboardName: "Alert", vcIdentifier: "AlertDoneChallenge") as! AlertDoneChallengeVC
        alertDoneChallengeVC.delegate = delegate
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(alertDoneChallengeVC, forKey: "contentViewController")
        
        let constraintHeight = NSLayoutConstraint(
            item: alertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
                NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 315)
        alertController.view.addConstraint(constraintHeight)
        
        // width constraint
        let constraintWidth = NSLayoutConstraint(
            item: alertController.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
                NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        alertController.view.addConstraint(constraintWidth)
        
        parentVC.present(alertController, animated: true, completion: nil)
    }
}

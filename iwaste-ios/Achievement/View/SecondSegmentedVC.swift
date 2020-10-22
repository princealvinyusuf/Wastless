//
//  SecondSegmentedVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import UIKit
import BonsaiController

class SecondSegmentedVC: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var subViewDay: UIView!
    @IBOutlet weak var subViewWeek: UIView!
    @IBOutlet weak var subViewMonth: UIView!
    @IBOutlet weak var subViewYear: UIView!
    
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subViewConfigure()
    }
    

    func subViewConfigure() {
        subViewDay.layer.cornerRadius = 10
        subViewDay.layer.shadowColor = UIColor.gray.cgColor
        subViewDay.layer.shadowOpacity = 0.6
        subViewDay.layer.shadowOffset = CGSize(width: -4, height: 6)
        subViewDay.layer.shadowRadius = 10
        
        subViewMonth.layer.cornerRadius = 10
        subViewMonth.layer.shadowColor = UIColor.gray.cgColor
        subViewMonth.layer.shadowOpacity = 0.6
        subViewMonth.layer.shadowOffset = CGSize(width: -4, height: 6)
        subViewMonth.layer.shadowRadius = 10
        
        subViewWeek.layer.cornerRadius = 10
        subViewWeek.layer.shadowColor = UIColor.gray.cgColor
        subViewWeek.layer.shadowOpacity = 0.6
        subViewWeek.layer.shadowOffset = CGSize(width: -4, height: 6)
        subViewWeek.layer.shadowRadius = 10
        
        subViewYear.layer.cornerRadius = 10
        subViewYear.layer.shadowColor = UIColor.gray.cgColor
        subViewYear.layer.shadowOpacity = 0.6
        subViewYear.layer.shadowOffset = CGSize(width: -4, height: 6)
        subViewYear.layer.shadowRadius = 10
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(SecondSegmentedVC.subViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        subViewDay.addGestureRecognizer(tapGesture)
        subViewDay.isUserInteractionEnabled = true
    }
    
    @objc func subViewTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Achievement", bundle: nil)
        let secondSegmentedVC = storyboard.instantiateViewController(identifier: "MedalsVC") as! MedalsVC
        SecondSegmentedVC.globalVariable.medals = "DayMedals"
        self.present(secondSegmentedVC, animated: true, completion: nil)
    }

    struct globalVariable {
        static var medals = String();
    }
    
}

extension SecondSegmentedVC: BonsaiControllerDelegate {
 
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
        
    }
}


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
    var tapGesture2 = UITapGestureRecognizer()
    var tapGesture3 = UITapGestureRecognizer()
    var tapGesture4 = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subViewConfigure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MedalsVC"{
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    

    func subViewConfigure() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(SecondSegmentedVC.subViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        subViewDay.addGestureRecognizer(tapGesture)
        subViewDay.isUserInteractionEnabled = true
        
        tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(SecondSegmentedVC.subViewTapped2(_:)))
        tapGesture2.numberOfTapsRequired = 1
        tapGesture2.numberOfTouchesRequired = 1
        subViewWeek.addGestureRecognizer(tapGesture2)
        subViewWeek.isUserInteractionEnabled = true
        
        tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(SecondSegmentedVC.subViewTapped3(_:)))
        tapGesture3.numberOfTapsRequired = 1
        tapGesture3.numberOfTouchesRequired = 1
        subViewMonth.addGestureRecognizer(tapGesture3)
        subViewMonth.isUserInteractionEnabled = true
        
        tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(SecondSegmentedVC.subViewTapped4(_:)))
        tapGesture4.numberOfTapsRequired = 1
        tapGesture4.numberOfTouchesRequired = 1
        subViewYear.addGestureRecognizer(tapGesture4)
        subViewYear.isUserInteractionEnabled = true
    }
    
    @objc func subViewTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Achievement", bundle: nil)
        let secondSegmentedVC = storyboard.instantiateViewController(identifier: "MedalsVC") as! MedalsVC
        SecondSegmentedVC.globalVariable.medals = "DayMedals"
        self.present(secondSegmentedVC, animated: true, completion: nil)
    }
    
    @objc func subViewTapped2(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Achievement", bundle: nil)
        let secondSegmentedVC = storyboard.instantiateViewController(identifier: "MedalsVC") as! MedalsVC
        SecondSegmentedVC.globalVariable.medals = "WeekMedals"
        self.present(secondSegmentedVC, animated: true, completion: nil)
    }
    
    @objc func subViewTapped3(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Achievement", bundle: nil)
        let secondSegmentedVC = storyboard.instantiateViewController(identifier: "MedalsVC") as! MedalsVC
        SecondSegmentedVC.globalVariable.medals = "MonthMedals"
        self.present(secondSegmentedVC, animated: true, completion: nil)
    }
    
    @objc func subViewTapped4(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Achievement", bundle: nil)
        let secondSegmentedVC = storyboard.instantiateViewController(identifier: "MedalsVC") as! MedalsVC
        SecondSegmentedVC.globalVariable.medals = "YearMedals"
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


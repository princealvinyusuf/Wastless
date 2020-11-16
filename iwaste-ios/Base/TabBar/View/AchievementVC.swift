//
//  AchievementVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import UIKit
import LinearProgressView

protocol AchievementDelegate {
    func refreshView()
    func upgradeLevel()
}

class AchievementVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var lblAchCategory: UILabel!
    @IBOutlet weak var lblAchDescription: UILabel!
    
    
    var presenter: AchievementPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AchievementPresenter()
        
        //        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        //        segmentedControl.isHidden = true
        
        viewDescription.layer.cornerRadius = 5
        viewDescription.layer.shadowColor = UIColor.black.cgColor
        viewDescription.layer.shadowRadius = 5
        viewDescription.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewDescription.layer.shadowOpacity = 0.3
        
        self.setupView()
        
    }
    
    func setupView() {
        updateView()
    }
    
    private lazy var activityVC: ActivityVC = {
        let storyboard = UIStoryboard(name: "Achievement", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ChallengesVC") as! ActivityVC
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var badgesVC: BadgesVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Achievement", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "BadgesVC") as! BadgesVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    static func viewController() -> AchievementVC {
        return UIStoryboard.init(name: "Base", bundle: nil).instantiateViewController(withIdentifier: "SegmentedView") as! AchievementVC
    }
    
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private func updateView() {
        //        if segmentedControl.selectedSegmentIndex == 0 {
        
        remove(asChildViewController: activityVC)
        add(asChildViewController: badgesVC)
        
        lblAchCategory.text = "Badges"
        lblAchDescription.text = "Badges collected shows your level in your Zero Waste life journey. You will earn a badge after reaching standard set for each badge."
        
        //        } else {
        //            remove(asChildViewController: badgesVC)
        //            add(asChildViewController: activityVC)
        //
        //            lblAchCategory.text = "Activities"
        //            lblAchDescription.text = "Beside collecting badges, you can challenge yourself to do the supporting activites. These are 21 days activities means you can done it after 21 days keep doing so. Each activity will be reset to undone, after 21 days of completion."
        //        }
    }
    
}

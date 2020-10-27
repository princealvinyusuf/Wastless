//
//  AchievementVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import UIKit
import LinearProgressView

class AchievementVC: UIViewController {

    
    @IBOutlet weak var linearProgressAchievement: LinearProgressView!
    @IBOutlet weak var totalCoinLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalCoinLabel.layer.cornerRadius = 8
        totalCoinLabel.layer.masksToBounds = true
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)

        
        linearProgressAchievement.animationDuration = 0.5
        linearProgressAchievement.barColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.7294117647, alpha: 1)
        linearProgressAchievement.trackColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        
        updateLinearProgress()
        
        self.setupView()
    }
    
    @objc
    func updateLinearProgress() {
        linearProgressAchievement.setProgress(80, animated: true)
        linearProgressAchievement.barInset = CGFloat(4)
        linearProgressAchievement.isCornersRounded = true
    }
    
    func setupView() {
        updateView()
    }
    
    private lazy var summaryViewController: FirstSegmentedVC = {
        let storyboard = UIStoryboard(name: "Achievement", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "FirstSegmentedVC") as! FirstSegmentedVC
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var sessionsViewController: SecondSegmentedVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Achievement", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SecondSegmentedVC") as! SecondSegmentedVC
        
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
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: sessionsViewController)
            add(asChildViewController: summaryViewController)
        } else {
            remove(asChildViewController: summaryViewController)
            add(asChildViewController: sessionsViewController)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

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
    
    @IBOutlet weak var linearProgressAchievement: LinearProgressView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgLevel: UIImageView!
    @IBOutlet weak var lblLevelName: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    
    var presenter: AchievementPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AchievementPresenter()
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)

        linearProgressAchievement.animationDuration = 0.5
        linearProgressAchievement.barColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.7294117647, alpha: 1)
        linearProgressAchievement.trackColor = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.3803921569, alpha: 1)
        
        updateLinearProgress()
        
        self.setupView()
        
        refreshView()
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

    private lazy var summaryViewController: ChallengesVC = {
        let storyboard = UIStoryboard(name: "Achievement", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ChallengesVC") as! ChallengesVC
        viewController.delegate = self
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var sessionsViewController: BadgesVC = {
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
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: sessionsViewController)
            add(asChildViewController: summaryViewController)
        } else {
            remove(asChildViewController: summaryViewController)
            add(asChildViewController: sessionsViewController)
        }
    }
    
}

extension AchievementVC: AchievementDelegate {
    func upgradeLevel() {
        
        refreshView()
    }
    
    func refreshView() {
        presenter?.loadDataLevel(completion: { (dataLevel, progress) in
            self.imgLevel.image = dataLevel.image
            self.lblLevelName.text = dataLevel.name
            
            let floatProgress = Float(progress)/Float(dataLevel.maxPoint)
            print("ffll: ", floatProgress)
            
            if UserDefaultService.instance.level == Level.ecoMaster.rawValue {
                self.linearProgressAchievement.setProgress(1, animated: true)
                self.lblProgress.text = "MAX"
            } else {
                self.lblProgress.text = "\(progress)/\(dataLevel.maxPoint)"
                self.linearProgressAchievement.setProgress(floatProgress, animated: true)
            }
        })
    }
}

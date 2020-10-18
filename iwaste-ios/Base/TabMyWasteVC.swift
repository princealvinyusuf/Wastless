//
//  TabMyWasteVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 10/10/20.
//

import UIKit
import LinearProgressView
import WaveAnimationView

class TabMyWasteVC: UIViewController {

    
    @IBOutlet weak var inputViewPlastic: UIView!
    @IBOutlet weak var inputViewGlass: UIView!
    @IBOutlet weak var inputViewPaper: UIView!
    @IBOutlet weak var inputViewMetal: UIView!
    @IBOutlet weak var inputViewOrganic: UIView!
    @IBOutlet weak var setTargetImage: UIImageView!
    @IBOutlet weak var setTargetOutlet: UIButton!
    
    @IBOutlet weak var textIntro: UILabel!
    
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var waveView: UIView!
    var tapGesture = UITapGestureRecognizer()
    var wave: WaveAnimationView!
    @IBOutlet weak var trashBinPercentage: UILabel!
    @IBOutlet weak var dateNavigationBar: UIBarButtonItem!
    
    
    @IBOutlet weak var linearProgressPlastics: LinearProgressView!
    @IBOutlet weak var linearProgressMetals: LinearProgressView!
    @IBOutlet weak var linearProgressGlass: LinearProgressView!
    @IBOutlet weak var linearProgressPapers: LinearProgressView!
    @IBOutlet weak var linearProgressOrganic: LinearProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDate()
        
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
        
        subViewConfigure()
        
        waveConfigure()
        waveColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "welcomeShown") == false{
            UserDefaults.standard.set(true, forKey: "welcomeShown")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Base", bundle:nil)
            let welcomeVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
            self.present(welcomeVC, animated:true, completion:nil)
            return
        }
        
    }
    
    func subViewConfigure() {
        subView.layer.cornerRadius = 10
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.5
        subView.layer.shadowOffset = CGSize(width: 0, height: 0)
        subView.layer.shadowRadius = 25.0
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabMyWasteVC.subViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        subView.addGestureRecognizer(tapGesture)
        subView.isUserInteractionEnabled = true
    }
    
    func currentDate() {
        let userCalendar = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        
        dateNavigationBar.title = "\(formatter.string(from: userCalendar))"
    }
    
    func waveConfigure() {
        wave = WaveAnimationView(frame: CGRect(origin: .zero, size: waveView.bounds.size), color: UIColor.blue.withAlphaComponent(0.5))
        waveView.addSubview(wave)
        wave.maskImage = UIImage(named: "wasteBasket")
        wave.startAnimation()
        
        // Change the value of Trash bin Wave
        wave.setProgress(0.65)
        trashBinPercentage.text = String(format: "%.0f", wave.progress*100) + "%"
        print("waveProgress",wave.progress)
    }
    
    func waveColor() {
        wave.frontColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(1)
        wave.backColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).withAlphaComponent(0.3)
        waveView.layer.borderColor = UIColor.gray.cgColor
    }
    
    @objc
    func updateLinearProgress() {
        linearProgressPlastics.setProgress(80, animated: true)
        linearProgressPlastics.barInset = CGFloat(4)
        linearProgressPlastics.isCornersRounded = true
        
        linearProgressMetals.setProgress(100, animated: true)
        linearProgressMetals.barInset = CGFloat(4)
        linearProgressMetals.isCornersRounded = true
        
        linearProgressGlass.setProgress(20, animated: true)
        linearProgressGlass.barInset = CGFloat(4)
        linearProgressGlass.isCornersRounded = true
        
        linearProgressPapers.setProgress(40, animated: true)
        linearProgressPapers.barInset = CGFloat(4)
        linearProgressPapers.isCornersRounded = true
        
        linearProgressOrganic.setProgress(60, animated: true)
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
    
    @IBAction func setTarget(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let setTargetVC = storyboard.instantiateViewController(identifier: "SetTarget") as! SetTargetVC
        show()
        hidden()
        self.present(setTargetVC, animated: true, completion: nil)
        
    }
    
    func hidden() {
        setTargetImage.isHidden = true
        setTargetOutlet.isHidden = true
        textIntro.isHidden = true
    }
    
    func show() {
        subView.isHidden = false
        inputViewPlastic.isHidden = false
        inputViewGlass.isHidden = false
        inputViewPaper.isHidden = false
        inputViewMetal.isHidden = false
        inputViewOrganic.isHidden = false
        trashBinPercentage.isHidden = false
        waveView.isHidden = false
        
    }
    
    
}


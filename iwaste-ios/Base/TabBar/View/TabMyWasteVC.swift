//
//  TabMyWasteVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 10/10/20.
//

import UIKit
import LinearProgressView
import WaveAnimationView
import UserNotifications

protocol WasteTargetDelegate {
    func updateUI()
    func checkTargetSet()
    func checkWasteCondition(type: WasteType)
}

class TabMyWasteVC: UIViewController {
    
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var setTargetImage: UIImageView!
    @IBOutlet weak var setTargetOutlet: UIButton!
    
    @IBOutlet weak var textIntro: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var waveView: UIView!
    var tapGesture = UITapGestureRecognizer()
    var wave: WaveAnimationView!
    @IBOutlet weak var trashBinPercentage: UILabel!
    @IBOutlet weak var dateNavigationBar: UIBarButtonItem!
    
    @IBOutlet weak var tableStats: UITableView!
    
    let udService = UserDefaultService.instance
    var presenter: MyWastePresenter?
    var categories: [CategoryCD]?
    
    let mainColor = [K.Color.colorPlastic, K.Color.colorGlass, K.Color.colorPaper, K.Color.colorMetal, K.Color.colorOrganic]
    let secondaryColor = [K.Color.colorPlasticSoft, K.Color.colorGlassSoft, K.Color.colorPaperSoft, K.Color.colorMetalSoft, K.Color.colorOrganicSoft]
    let textColor = [K.Color.colorPlasticText, K.Color.colorGlassText, K.Color.colorPaperText, K.Color.colorMetalText, K.Color.colorOrganicText]
    let catName = [WasteType.plastic.rawValue, WasteType.glass.rawValue, WasteType.paper.rawValue, WasteType.metal.rawValue, WasteType.organic.rawValue]
    var arrayTarget = [Int]()
    var arrayWasteCount = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MyWastePresenter(delegate: self)
        let isEmpty = presenter?.checkTodayData()
        
        collectionCategory.delegate = self
        collectionCategory.dataSource = self
        collectionCategory.register(UINib(nibName: "CardCategoryCell", bundle: self.nibBundle), forCellWithReuseIdentifier: "cardCategoryCell")
        
        tableStats.delegate = self
        tableStats.dataSource = self
        tableStats.register(UINib(nibName: "MainStatsCell", bundle: self.nibBundle), forCellReuseIdentifier: "mainStatsCell")
        
        // Collection View
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 72, height: 115)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionCategory.collectionViewLayout = flowLayout
        
        self.updateUI()
        
        subViewConfigure()
        
        waveConfigure()
        waveColor()
        
        if isEmpty!{
            main(isHidden: false)
            target(isHidden: true)
            checkTargetSet()
        }else{
            main(isHidden: true)
            target(isHidden: false)
        }
        
        presenter?.getTodayDate(completion: { (date) in
            self.dateNavigationBar.title = "\(date)"
        })
        
        let isBadgeComplete = BadgeService.isBadgeComplete()
        if isBadgeComplete {
            let util = AlertUtil()
            util.showAlertLevelUp(parentVC: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
        if !udService.isFirstLaunched {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Base", bundle:nil)
            let welcomeVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
            self.present(welcomeVC, animated:true, completion:nil)
            return
        }
        
        NotificationService.instance.scheduleDailyReminder()
    }
    
    func subViewConfigure() {
        subView.layer.cornerRadius = 10
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.2
        subView.layer.shadowOffset = CGSize(width: 0, height: 0)
        subView.layer.shadowRadius = 25.0
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabMyWasteVC.subViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        subView.addGestureRecognizer(tapGesture)
        subView.isUserInteractionEnabled = true
    }
    
    func waveConfigure() {
        wave = WaveAnimationView(frame: CGRect(origin: .zero, size: waveView.bounds.size), color: UIColor.blue.withAlphaComponent(0.5))
        waveView.addSubview(wave)
        wave.maskImage = UIImage(named: "wasteBasket")
        wave.startAnimation()
        
        // Change the value of Trash bin Wave
        wave.setProgress(0)
        trashBinPercentage.text = String(format: "%.0f", wave.progress*100) + "%"
    }
    
    func waveColor() {
        wave.frontColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(1)
        wave.backColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).withAlphaComponent(0.3)
        waveView.layer.borderColor = UIColor.gray.cgColor
    }
    
    @objc func subViewTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let currentWasteVC = storyboard.instantiateViewController(identifier: "CurrentWasteVC") as! CurrentWasteVC
        self.present(currentWasteVC, animated: true, completion: nil)
    }
    
    @IBAction func setTarget(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let setTargetVC = storyboard.instantiateViewController(identifier: "SetTarget") as! SetTargetVC
        setTargetVC.delegate = self
        self.present(setTargetVC, animated: true, completion: nil)
    }
    
    func target(isHidden: Bool) {
        setTargetImage.isHidden = isHidden
        setTargetOutlet.isHidden = isHidden
        textIntro.isHidden = isHidden
    }
    
    func main(isHidden: Bool) {
        subView.isHidden = isHidden
        collectionCategory.isHidden = isHidden
        trashBinPercentage.isHidden = isHidden
        waveView.isHidden = isHidden
    }
}

extension TabMyWasteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataWaste.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCategoryCell", for: indexPath) as? CardCategoryCell else {return UICollectionViewCell()}
        
        cell.configureCell(cat: dataWaste[indexPath.row], order: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = dataWaste[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addNewWasteVC = storyboard.instantiateViewController(identifier: "AddNewWasteVC") as! AddNewWasteVC
        addNewWasteVC.selectedCategory = category
        addNewWasteVC.delegate = self
        self.present(addNewWasteVC, animated: true, completion: nil)
    }
}

extension TabMyWasteVC: WasteTargetDelegate {
    func checkWasteCondition(type: WasteType) {
        if categories!.count > 0{
            presenter?.loadDataTrash(categories: categories, type: type) { (wasteCount, target, progress) in
                
                var warningType = Warning.reachedGeneral
                switch type {
                case .plastic:
                    warningType = .almostPlastic
                case .glass:
                    warningType = .almostGlass
                case .paper:
                    warningType = .almostPaper
                case .metal:
                    warningType = .almostMetal
                case .organic:
                    warningType = .almostOrganic
                }
                
                let data = WasteWarning.getSelectedDataWarning(type: warningType)
                print("progressWasteAdded: ", progress)
                if progress >= 80 {
                    DispatchQueue.main.async {
                        let util = AlertUtil()
                        util.showAlertWarningWaste(parentVC: self, model: data)
                    }
                }
            }
        }
    }
    
    func updateUI() {
        presenter?.loadCategory()
        
        arrayTarget.removeAll()
        arrayWasteCount.removeAll()
        
        //Change UI for Linear Progress
        if categories!.count > 0{
            // Plastic
            presenter?.loadDataTrash(categories: categories, type: .plastic) { (wasteCount, target, progress) in
                self.arrayTarget.append(target)
                self.arrayWasteCount.append(wasteCount)
            }
            
            // Glass
            presenter?.loadDataTrash(categories: categories, type: .glass) { (wasteCount, target, progress) in
                self.arrayTarget.append(target)
                self.arrayWasteCount.append(wasteCount)
            }
            
            // Papers
            presenter?.loadDataTrash(categories: categories, type: .paper) { (wasteCount, target, progress) in
                self.arrayTarget.append(target)
                self.arrayWasteCount.append(wasteCount)
            }
            
            // Metals
            presenter?.loadDataTrash(categories: categories, type: .metal) { (wasteCount, target, progress) in
                self.arrayTarget.append(target)
                self.arrayWasteCount.append(wasteCount)
            }
            
            // Organics
            presenter?.loadDataTrash(categories: categories, type: .organic) { (wasteCount, target, progress) in
                self.arrayTarget.append(target)
                self.arrayWasteCount.append(wasteCount)
            }
            
            tableStats.reloadData()
        }
    }
    
    func checkTargetSet(){
        if categories!.count > 0{
            main(isHidden: false)
            target(isHidden: true)
            
            wave = WaveAnimationView(frame: CGRect(origin: .zero, size: waveView.bounds.size), color: UIColor.blue.withAlphaComponent(0.5))
            waveView.addSubview(wave)
            wave.maskImage = UIImage(named: "wasteBasket")
            wave.startAnimation()
            presenter?.totalTrashUsage(){ (progress) in
                self.wave.setProgress(progress)
            }
            trashBinPercentage.text = String(format: "%.0f", wave.progress*100) + "%"
            wave.frontColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(1)
            wave.backColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).withAlphaComponent(0.3)
            waveView.layer.borderColor = UIColor.gray.cgColor
            
            print("waveProgress",wave.progress)
            
            // Check if num of waste reach the target
            var warningType: Warning!
            if wave.progress >= 0.75 && wave.progress < 1 {
                warningType = .almostGeneral
            } else if wave.progress >= 1 {
                warningType = .reachedGeneral
            }
            
            // show alert reminder when almost or reached the target
            if let type = warningType {
                let dataWarning = WasteWarning.getSelectedDataWarning(type: type)
                DispatchQueue.main.async {
                    let util = AlertUtil()
                    util.showAlertWarningWaste(parentVC: self, model: dataWarning)
                }
            }
        }else {
            main(isHidden: true)
            target(isHidden: false)
        }
    }
}

extension TabMyWasteVC: MyWasteDelegate {
    func dataCategoriesSuccess(categories: [CategoryCD]) {
        self.categories?.removeAll()
        self.categories = categories
    }
    
    func dataCategoriesFail(error: Error) {
        print("error data categories: ", error.localizedDescription)
    }
}

extension TabMyWasteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataWaste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainStatsCell") as? MainStatsCell else {return UITableViewCell()}
        
        let i = indexPath.row
        if arrayTarget.count > 0 {
            cell.configureCell(
                mainColor: mainColor[i],
                secondaryColor: secondaryColor[i],
                catName: catName[i],
                target: arrayTarget[i],
                wasteCount: arrayWasteCount[i],
                textColor: textColor[i]
            )
        }
        return cell
    }
}

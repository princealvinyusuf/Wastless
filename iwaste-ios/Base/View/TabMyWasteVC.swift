//
//  TabMyWasteVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 10/10/20.
//

import UIKit
import LinearProgressView
import WaveAnimationView
import CoreData

protocol WasteTargetDelegate {
    func updateUI()
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
    
    @IBOutlet weak var linearProgressPlastics: LinearProgressView!
    @IBOutlet weak var linearProgressMetals: LinearProgressView!
    @IBOutlet weak var linearProgressGlass: LinearProgressView!
    @IBOutlet weak var linearProgressPapers: LinearProgressView!
    @IBOutlet weak var linearProgressOrganic: LinearProgressView!
    
    @IBOutlet weak var plasticLabel: UILabel!
    @IBOutlet weak var metalLabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    @IBOutlet weak var paperLabel: UILabel!
    @IBOutlet weak var organicLabel: UILabel!
    
    
    let udService = UserDefaultService.instance
    
    //Core Data
    var managedObjectContext: NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //coredata
        managedObjectContext = appDelegate?.persistentContainer.viewContext
        
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
        
        self.updateUI()
        
        subViewConfigure()
        
        waveConfigure()
        waveColor()
        
        print(udService.isTargetSet)
        if udService.isTargetSet {
            main(isHidden: false)
            target(isHidden: true)
        } else {
            main(isHidden: true)
            target(isHidden: false)
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 72, height: 115)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionCategory.collectionViewLayout = flowLayout
        
        collectionCategory.delegate = self
        collectionCategory.dataSource = self
        collectionCategory.register(UINib(nibName: "CardCategoryCell", bundle: self.nibBundle), forCellWithReuseIdentifier: "cardCategoryCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateUI()
        
        if !udService.isFirstLaunched {
            udService.isFirstLaunched = true
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
        if category.isEmpty{
            print("Category Is Empty")

        }else{
            for i in 0...4{
                let target = Int(exactly: category[i].target)
                var count:Int = 0
                for n in 0...5{
                    if i == 0 {
                        let data = Int(exactly: trashPlastic[n].count)
                        count = count + data!
                    }else if i == 1{
                        let data = Int(exactly: trashGlass[n].count)
                        count = count + data!
                    }else if i == 2{
                        let data = Int(exactly: trashPaper[n].count)
                        count = count + data!
                    }else if i == 3{
                        let data = Int(exactly: trashMetal[n].count)
                        count = count + data!
                    }else if i == 4{
                        let data = Int(exactly: trashOrganic[n].count)
                        count = count + data!
                    }else if i == 5{

                    }
                }
                let progressBar: Float = Float(count)/Float(target!)*100
                if i == 0 {
                    linearProgressPlastics.setProgress(progressBar, animated: true)
                    linearProgressPlastics.barInset = CGFloat(4)
                    linearProgressPlastics.isCornersRounded = true
                    let text = String(target!)
                    let text2 = String(count)
                    plasticLabel.text = "\(text2) of \(text)"
                }else if i == 1{
                    linearProgressGlass.setProgress(progressBar, animated: true)
                    linearProgressGlass.barInset = CGFloat(4)
                    linearProgressGlass.isCornersRounded = true
                    let text = String(target!)
                    let text2 = String(count)
                    glassLabel.text = "\(text2) of \(text)"
                }else if i == 2{
                    linearProgressPapers.setProgress(progressBar, animated: true)
                    linearProgressPapers.barInset = CGFloat(4)
                    linearProgressPapers.isCornersRounded = true
                    let text = String(target!)
                    let text2 = String(count)
                    paperLabel.text = "\(text2) of \(text)"
                }else if i == 3{
                    linearProgressMetals.setProgress(progressBar, animated: true)
                    linearProgressMetals.barInset = CGFloat(4)
                    linearProgressMetals.isCornersRounded = true
                    let text = String(target!)
                    let text2 = String(count)
                    metalLabel.text = "\(text2) of \(text)"
                }else if i == 4{
                    linearProgressOrganic.setProgress(progressBar, animated: true)
                    linearProgressOrganic.barInset = CGFloat(4)
                    linearProgressOrganic.isCornersRounded = true
                    let text = String(target!)
                    let text2 = String(count)
                    organicLabel.text = "\(text2) of \(text)"
                }
            }
        }
        
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
        target(isHidden: true)
        main(isHidden: false)
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
    
    //Core Data Function
    func loadDataCat(){
        let catRequest: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
        catRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do{
            try category = managedObjectContext!.fetch(catRequest)
        }catch{
            print("Error Data couldnot be shown")
        }
    }
    
    func loadDataTrash(){
        let trashPlasticRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        let trashGlassRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        let trashPaperRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        let trashMetalRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        let trashOrganicRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
        
        trashPlasticRequest.predicate = NSPredicate(format: "type=%@", "Plastic")
        trashGlassRequest.predicate = NSPredicate(format: "type=%@", "Glass")
        trashPaperRequest.predicate = NSPredicate(format: "type=%@", "Paper")
        trashMetalRequest.predicate = NSPredicate(format: "type=%@", "Metal")
        trashOrganicRequest.predicate = NSPredicate(format: "type=%@", "Organic")
        
        trashPlasticRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        trashGlassRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        trashPaperRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        trashMetalRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        trashOrganicRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        
        do{
            try trashPlastic = managedObjectContext!.fetch(trashPlasticRequest)
            try trashGlass = managedObjectContext!.fetch(trashGlassRequest)
            try trashPaper = managedObjectContext!.fetch(trashPaperRequest)
            try trashMetal = managedObjectContext!.fetch(trashMetalRequest)
            try trashOrganic = managedObjectContext!.fetch(trashOrganicRequest)
        }catch{
            print("Error Data couldnot be shown")
        }
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
        self.present(addNewWasteVC, animated: true, completion: nil)
    }
}

extension TabMyWasteVC: WasteTargetDelegate {
    func updateUI() {
        loadDataCat()
        loadDataTrash()
        updateLinearProgress()
    }
}

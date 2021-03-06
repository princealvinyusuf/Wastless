//
//  CurrentViewCell.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 17/10/20.
//

import UIKit
import LinearProgressView

class CurrentViewCell: UITableViewCell {
    
    @IBOutlet weak var txtWasteName: UILabel!
    @IBOutlet weak var txtWasteTargetStatus: UILabel!
    @IBOutlet weak var linearWasteProgress: LinearProgressView!
    @IBOutlet weak var collectionWaste: UICollectionView!
    
    var listWaste = [Waste]()
    var listTrash = [TrashCD]()
    override func awakeFromNib() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 73, height: 105)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionWaste.collectionViewLayout = flowLayout
        
        self.collectionWaste.delegate = self
        self.collectionWaste.dataSource = self
        self.collectionWaste.register(UINib(nibName: "HorizontalModalCurrentWaste", bundle: nil), forCellWithReuseIdentifier: "horizontalModalCurrentWaste")
        
    }
    
    func configureCell(modelWaste: ModelWaste, target: Int, _ order: Int, trashData: TrashData) {
        txtWasteName.text = modelWaste.categoryName
        
        listWaste = modelWaste.waste
        listTrash = trashData.trash
        linearWasteProgress.animationDuration = 0.5
        setProgressColor(order)
                
        var count:Int = 0
        for i in 0...5{
            let data = Int(exactly: listTrash[i].count)
            count = count + data!
        }
        
        var progressNum: Float = 0.0
        if target > 0 {
            progressNum = Float(count)/Float(target)
        } else if count > target {
            progressNum = 1.0
        }
        
        linearWasteProgress.setProgress(progressNum, animated: true)
        linearWasteProgress.barInset = CGFloat(4)
        linearWasteProgress.isCornersRounded = true
        let text = String(count)
        let text2 = String(target)
        txtWasteTargetStatus.text = ("\(text) of \(text2)")
    }
    
    private func setProgressColor(_ order: Int) {
        
        txtWasteName.textColor = UIColor(named: "organicLabel")
        txtWasteTargetStatus.textColor = UIColor(named: "organicLabel")
        var progressTrackColor = K.Color.colorOrganic
        var progressBarColor = K.Color.colorOrganicSoft
        
        if order == 0 {
            txtWasteName.textColor = UIColor(named: "plasticLabel")
            txtWasteTargetStatus.textColor = UIColor(named: "plasticLabel")
            progressTrackColor = K.Color.colorPlastic
            progressBarColor = K.Color.colorPlasticSoft
        } else if order == 1 {
            txtWasteName.textColor = UIColor(named: "glassLabel")
            txtWasteTargetStatus.textColor = UIColor(named: "glassLabel")
            progressTrackColor = K.Color.colorGlass
            progressBarColor = K.Color.colorGlassSoft
        } else if order == 2 {
            txtWasteName.textColor = UIColor(named: "paperLabel")
            txtWasteTargetStatus.textColor = UIColor(named: "paperLabel")
            progressTrackColor = K.Color.colorPaper
            progressBarColor = K.Color.colorPaperSoft
        } else if order == 3 {
            txtWasteName.textColor = UIColor(named: "metalLabel")
            txtWasteTargetStatus.textColor = UIColor(named: "metalLabel")
            progressTrackColor = K.Color.colorMetal
            progressBarColor = K.Color.colorMetalSoft
        }
        
        linearWasteProgress.barColor = progressBarColor
        linearWasteProgress.trackColor = progressTrackColor
    }
}

extension CurrentViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listWaste.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalModalCurrentWaste", for: indexPath) as? HorizontalModalCurrentWaste else {return UICollectionViewCell()}
        let trashCount = Int(exactly: listTrash[indexPath.row].count)
        let wasteAdded = WasteAdded(waste: listWaste[indexPath.row], numOfWaste: trashCount!)
        cell.configureCell(wasteAdded: wasteAdded)
        
        return cell
    }
    
}

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
    
}

extension CurrentViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalModalCurrentWaste", for: indexPath) as? HorizontalModalCurrentWaste else {return UICollectionViewCell()}
        
        return cell
    }
    
}

//
//  HorizontalModalCurrentWaste.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 15/10/20.
//

import UIKit

class HorizontalModalCurrentWaste: UICollectionViewCell {

    @IBOutlet weak var imgCurrentWaste: UIImageView!
    @IBOutlet weak var txtCurrentWaste: UILabel!
    @IBOutlet weak var numberCurrentWaste: UILabel!
        
    func configureCell(wasteAdded: WasteAdded) {
        imgCurrentWaste.image = wasteAdded.waste.wasteImg
        txtCurrentWaste.text = wasteAdded.waste.wasteName
    }
}

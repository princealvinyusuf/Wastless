//
//  WasteViewCell.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 14/10/20.
//

import UIKit

class WasteViewCell: UITableViewCell {

    @IBOutlet weak var imgWaste: UIImageView!
    @IBOutlet weak var txtWasteStatus: UILabel!
    
    func configureCell(wasteAdded: WasteAdded) {
        imgWaste.image = wasteAdded.waste.wasteImg
        txtWasteStatus.text = "\(wasteAdded.numOfWaste) \(wasteAdded.waste.wasteName) added"
    }
}

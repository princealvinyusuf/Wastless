//
//  HorizontalModalListView.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 14/10/20.
//

import UIKit

class HorizontalModalListView: UICollectionViewCell {

    @IBOutlet weak var imgWaste: UIImageView!
    @IBOutlet weak var txtWaste: UILabel!
    @IBOutlet weak var viewBG: UIView!
    
    func configureCell(waste: Waste) {
        imgWaste.image = waste.wasteImg
        txtWaste.text = waste.wasteName
    }
    
    override var isSelected: Bool {
        didSet {
            viewBG.layer.borderWidth = isSelected ? 1 : 0
            viewBG.layer.borderColor = isSelected ? UIColor(named: "navigationBarModal")!.cgColor : UIColor.clear.cgColor
        }
    }
}

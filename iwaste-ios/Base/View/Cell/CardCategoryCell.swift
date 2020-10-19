//
//  CardCategoryCell.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 19/10/20.
//

import UIKit

class CardCategoryCell: UICollectionViewCell {

    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblNameCategory: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewParent.layer.cornerRadius = 14
    }

    func configureCell(cat: ModelWaste, order: Int) {
        imgCategory.image = cat.categoryImg
        lblNameCategory.text = cat.categoryName
        
        setColorCategory(order)
    }
    
    private func setColorCategory(_ order: Int) {
        var bgButtonColor = K.Color.colorOrganic
        var bgViewColor = K.Color.colorOrganicSoft
        
        if order == 0 {
            bgButtonColor = K.Color.colorPlastic
            bgViewColor = K.Color.colorPlasticSoft
        } else if order == 1 {
            bgButtonColor = K.Color.colorGlass
            bgViewColor = K.Color.colorGlassSoft
        } else if order == 2 {
            bgButtonColor = K.Color.colorPaper
            bgViewColor = K.Color.colorPaperSoft
        } else if order == 3 {
            bgButtonColor = K.Color.colorMetal
            bgViewColor = K.Color.colorMetalSoft
        }
        
        btnAdd.tintColor = bgButtonColor
        viewParent.backgroundColor = bgViewColor
    }
}

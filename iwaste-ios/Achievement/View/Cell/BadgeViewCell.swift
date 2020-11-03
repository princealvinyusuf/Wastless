//
//  BadgeViewCell.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 03/11/20.
//

import UIKit

class BadgeViewCell: UICollectionViewCell {

    @IBOutlet weak var imgBadge: UIImageView!
    @IBOutlet weak var lblTitleBadge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(badge: Badges) {
        imgBadge.image = badge.image
        lblTitleBadge.text = badge.title
    }
}

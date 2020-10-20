//
//  TableViewCell.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var subView: UIView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        coinLabel.text = nil
        iconImage.image = nil
    }
    
    func configurateTheCell(_ challenge: Challenge) {
        titleLabel.text = challenge.title
        coinLabel.text = challenge.coin
        iconImage.image = UIImage(named: challenge.image)
        subView.backgroundColor =  #colorLiteral(red: 1, green: 0.9176470588, blue: 0.9098039216, alpha: 1)
        
        subView.layer.cornerRadius = 20
        subView.layer.borderWidth = 0.1
        subView.layer.borderColor = UIColor.lightGray.cgColor
        subView.layer.masksToBounds = true
        subView.layer.shadowColor = UIColor.gray.cgColor
        subView.layer.shadowOffset = CGSize(width: 0, height: 0)
        subView.layer.shadowRadius = 7.0
        subView.layer.shadowOpacity = 0.3
        subView.layer.masksToBounds = false
//        subView.layer.shadowPath = UIBezierPath(roundedRect:subView.bounds, cornerRadius:subView.layer.cornerRadius).cgPath

    }
}

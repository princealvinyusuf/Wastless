//
//  DetailHistoryCell.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 24/10/20.
//

import UIKit

class DetailHistoryCell: UITableViewCell {

    @IBOutlet weak var lblNameWaste: UILabel!
    @IBOutlet weak var lblNumWaste: UILabel!
    @IBOutlet weak var viewParent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewParent.layer.cornerRadius = 11
    }

    func configureCell() {
        
    }
    
}

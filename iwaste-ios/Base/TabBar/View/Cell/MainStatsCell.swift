//
//  MainStatsCell.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 16/11/20.
//

import UIKit
import LinearProgressView

class MainStatsCell: UITableViewCell {

    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var linearProgress: LinearProgressView!
    @IBOutlet weak var lblNumOfTrash: UILabel!
    
    func configureCell(mainColor: UIColor, secondaryColor: UIColor, catName: String, target: Int, wasteCount: Int, textColor: UIColor) {
        setupUI(mainColor, secondaryColor, textColor)

        lblNumOfTrash.text = "\(wasteCount) of \(target)"
        lblCategoryName.text = catName

        var progressNum: Float = 0.0
        if target > 0 {
            progressNum = Float(wasteCount)/Float(target)
        } else if wasteCount > target {
            progressNum = 1.0
        }
        linearProgress.setProgress(progressNum, animated: true)
    }
    
    func setupUI(_ mainColor: UIColor, _ secondaryColor: UIColor, _ textColor: UIColor) {
        linearProgress.animationDuration = 0.5
        linearProgress.barColor = secondaryColor
        linearProgress.trackColor = mainColor
        linearProgress.barInset = CGFloat(4)
        linearProgress.isCornersRounded = true
        
        lblCategoryName.textColor = textColor
        lblNumOfTrash.textColor = textColor
    }
}

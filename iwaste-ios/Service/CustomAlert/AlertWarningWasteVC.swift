//
//  AlertWarningWasteVC.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/12/20.
//

import UIKit

class AlertWarningWasteVC: UIViewController {

    @IBOutlet weak var lblDescWarning: UILabel!
    @IBOutlet weak var imgWasteWarning: UIImageView!
    @IBOutlet weak var btnOkay: UIButton!
    
    var model: WasteWarning?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOkay.layer.cornerRadius = btnOkay.frame.height/2
        
        lblDescWarning.text = model?.desc
        imgWasteWarning.image = model?.img
    }
    
    @IBAction func btnOkayPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

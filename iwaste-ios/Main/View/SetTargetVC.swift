//
//  SetTargetVC.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 18/10/20.
//

import UIKit

class SetTargetVC: UIViewController {

    @IBAction func btnDone(_ sender: UIBarButtonItem) {
        // set to true so target screen wont show up after target is set
        UserDefaultService.instance.isTargetSet = true
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

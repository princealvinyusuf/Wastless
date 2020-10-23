//
//  ModelWaste.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/10/20.
//

import UIKit

struct ModelWaste {
    let categoryName: String
    let categoryImg: UIImage
    let waste: [Waste]
}

struct Waste {
    let wasteName: String
    let wasteImg: UIImage
}

struct TrashData{
    var trashname: String
    var trash: [TrashCD]
}

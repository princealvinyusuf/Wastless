//
//  ModelLevel.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 01/11/20.
//

import UIKit

struct ModelLevel {
    let name: String
    let image: UIImage
    let minPoint: Int
    let maxPoint: Int
}

enum Level: String {
    case novice = "novice"
    case ecoStarter = "ecoStarter"
    case ecoFriendly = "ecoFriendly"
    case ecoMaster = "ecoMaster"
}

func getDataLevel(level: Level) -> ModelLevel {
    var model: ModelLevel!
    
    switch level {
    case .novice:
        model = ModelLevel(name: "Novice", image: UIImage(named: "econovice")!, minPoint: 0, maxPoint: 100)
    case .ecoStarter:
        model = ModelLevel(name: "Eco Starter", image: UIImage(named: "ecostarter")!, minPoint: 100, maxPoint: 300)
    case .ecoFriendly:
        model = ModelLevel(name: "Eco Friendly", image: UIImage(named: "ecofriendly")!, minPoint: 400, maxPoint: 500)
    case .ecoMaster:
        model = ModelLevel(name: "Eco Master", image: UIImage(named: "ecomaster")!, minPoint: 900, maxPoint: 9999)
    }
    
    return model
}

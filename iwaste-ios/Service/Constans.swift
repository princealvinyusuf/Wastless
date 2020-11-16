//
//  Constans.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/10/20.
//

import UIKit

struct K {
    struct Color {
        static let primaryColor = UIColor(named: "navigationBarModal")!
        static let primarySoft = UIColor(named: "navBarSoft")!
        
        static let colorPlastic = UIColor(named: "plastic")!
        static let colorPlasticSoft = UIColor(named: "plasticSoft")!
        static let colorPlasticText = UIColor(named: "plasticLabel")!

        static let colorPaper = UIColor(named: "paper")!
        static let colorPaperSoft = UIColor(named: "paperSoft")!
        static let colorPaperText = UIColor(named: "paperLabel")!

        static let colorOrganic = UIColor(named: "organic")!
        static let colorOrganicSoft = UIColor(named: "organicSoft")!
        static let colorOrganicText = UIColor(named: "organicLabel")!

        static let colorMetal = UIColor(named: "metal")!
        static let colorMetalSoft = UIColor(named: "metalSoft")!
        static let colorMetalText = UIColor(named: "metalLabel")!

        static let colorGlass = UIColor(named: "glass")!
        static let colorGlassSoft = UIColor(named: "glassSoft")!
        static let colorGlassText = UIColor(named: "glassLabel")!

    }
    
    struct Core {
        static let badgeEntity = "BadgeCD"
        static let badgeNum = "badgeNum"
        static let badgeDate = "badgeDate"
    }
}

enum WasteType: String {
    case plastic = "Plastic"
    case glass = "Glass"
    case paper = "Paper"
    case metal = "Metal"
    case organic = "Organic"
}

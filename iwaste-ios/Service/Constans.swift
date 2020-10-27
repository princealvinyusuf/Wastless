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

        static let colorPaper = UIColor(named: "paper")!
        static let colorPaperSoft = UIColor(named: "paperSoft")!

        static let colorOrganic = UIColor(named: "organic")!
        static let colorOrganicSoft = UIColor(named: "organicSoft")!

        static let colorMetal = UIColor(named: "metal")!
        static let colorMetalSoft = UIColor(named: "metalSoft")!

        static let colorGlass = UIColor(named: "glass")!
        static let colorGlassSoft = UIColor(named: "glassSoft")!
    }
}

enum WasteType: String {
    case plastic = "Plastic"
    case glass = "Glass"
    case paper = "Paper"
    case metal = "Metal"
    case organic = "Organic"
}

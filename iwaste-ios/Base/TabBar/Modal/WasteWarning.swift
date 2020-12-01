//
//  WasteWarning.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/12/20.
//

import UIKit

enum Warning {
    case almostPlastic
    case almostPaper
    case almostGlass
    case almostMetal
    case almostOrganic
    case almostGeneral
    case reachedGeneral
}

struct WasteWarning {
    let desc: String
    let img: UIImage
    let type: Warning
}

extension WasteWarning {
    static func getDataWarning() -> [WasteWarning] {
        return [
            WasteWarning(
                desc: "Your plastic waste has almost reached the target. Avoid using plastic to keep you on track.",
                img: UIImage(named: "wastePlastic")!,
                type: .almostPlastic
            ),
            WasteWarning(
                desc: "Your paper waste has almost reached the target. Avoid using paper to keep you on track.",
                img: UIImage(named: "wastePaper")!,
                type: .almostPaper
            ),
            WasteWarning(
                desc: "Your glass waste has almost reached the target. Avoid using 1 time glass material to keep you on track.",
                img: UIImage(named: "wasteGlass")!,
                type: .almostGlass
            ),
            WasteWarning(
                desc: "Your metal waste has almost reached the target. Avoid to spoil more metal to keep you on track.",
                img: UIImage(named: "wasteMetal")!,
                type: .almostMetal
            ),
            WasteWarning(
                desc: "Your organic waste has almost reached the target. Finish your meal and reduce more waste to keep you on track.",
                img: UIImage(named: "wasteOrganic")!,
                type: .almostOrganic
            ),
            WasteWarning(
                desc: "Your waste production today almost reached target. Let’s not go overboard!",
                img: UIImage(named: "wasteGeneral")!,
                type: .almostGeneral
            ),
            WasteWarning(
                desc: "You’ve reached your target, let’s stop wasting more!",
                img: UIImage(named: "wasteGeneral")!,
                type: .reachedGeneral
            )
        ]
    }
    
    static func getSelectedDataWarning(type: Warning) -> WasteWarning {
        var dataWarning = self.getDataWarning()
        
        dataWarning = dataWarning.filter { $0.type == type }
        
        return dataWarning.first!
    }
}

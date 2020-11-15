//
//  Badges.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 03/11/20.
//

import UIKit

struct Badges {
    let title: String
    let image: UIImage
    let missionBin: Int
}

extension Badges {
    static func createBadges() -> [Badges] {
        return [
            Badges(
                title: "Trash Picker",
                image: UIImage(named: "trashPicker")!,
                missionBin: 50
            ),
            Badges(
                title: "Eco Sprinter",
                image: UIImage(named: "ecoSprinter")!,
                missionBin: 40
            ),
            Badges(
                title: "Eco Adventurer",
                image: UIImage(named: "ecoAdventurer")!,
                missionBin: 30
            ),
            Badges(
                title: "Zero Waste Master",
                image: UIImage(named: "zeroWasteMaster")!,
                missionBin: 20
            )
        ]
    }
}

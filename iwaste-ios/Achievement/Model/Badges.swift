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
    let missionChallenge: [Int]
}

extension Badges {
    static func createBadges() -> [Badges] {
        return [
            Badges(
                title: "Trash Picker",
                image: UIImage(named: "trashPicker")!,
                missionBin: 50,
                missionChallenge: []
            ),
            Badges(
                title: "Eco Sprinter",
                image: UIImage(named: "ecoSprinter")!,
                missionBin: 40,
                missionChallenge: [0,1]
            ),
            Badges(
                title: "Eco Adventurer",
                image: UIImage(named: "ecoAdventurer")!,
                missionBin: 30,
                missionChallenge: [2,3]
            ),
            Badges(
                title: "Zero Waste Master",
                image: UIImage(named: "zeroWasteMaster")!,
                missionBin: 20,
                missionChallenge: [4]
            )
        ]
    }
}

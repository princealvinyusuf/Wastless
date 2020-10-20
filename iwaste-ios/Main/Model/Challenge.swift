//
//  Challenge.swift
//  iwaste-ios
//
//  Created by Prince Alvin Yusuf on 20/10/20.
//

import Foundation

struct Challenge {
    let title: String
    let image: String
    let coin: String
}

extension Challenge {
    static func createChallenge() -> [Challenge] {
        return [Challenge(title: "Bring Your Tumbler", image: "tumbler", coin: "50"),
                Challenge(title: "Use Metal Straw", image: "metalStraw", coin: "80"),
                Challenge(title: "Use Shopping Bag", image: "shoppingBag", coin: "100"),
                Challenge(title: "Bring Your Cutleries", image: "cutleries", coin: "120"),
                Challenge(title: "Use Organic Soap", image: "organicSoap", coin: "140")]
    }
}


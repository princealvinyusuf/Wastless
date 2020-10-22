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
    let challengeDetail: String
}

extension Challenge {
    static func createChallenge() -> [Challenge] {
        return [Challenge(title: "Bring Your Tumbler", image: "tumbler", coin: "50", challengeDetail: "Bring your own drink bottle is great for you and the environment. Here are some key reasons: \n\n1. Reduce waste with an eco water bottle \n2. Save more money! \n3. Protect your health \n4. Send a message, join a worldwide movement \n5. Plastic bottles have plastic fibers in them... so you're drinking plastic"),
                Challenge(title: "Use Metal Straw", image: "metalStraw", coin: "80", challengeDetail: "Lorem ipsum dolor sit amet"),
                Challenge(title: "Use Shopping Bag", image: "shoppingBag", coin: "100", challengeDetail: "Ex1"),
                Challenge(title: "Bring Your Cutleries", image: "cutleries", coin: "120", challengeDetail: "Ex2"),
                Challenge(title: "Use Organic Soap", image: "organicSoap", coin: "140", challengeDetail: "Ex3")]
    }
}


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
        return [Challenge(title: "Bring Your Tumbler", image: "tumbler", coin: "30", challengeDetail: "Bring your own drink bottle is great for you and the environment. Here are some key reasons: \n\n1. Reduce waste with an eco water bottle \n2. Save more money! \n3. Protect your health \n4. Send a message, join a worldwide movement \n5. Plastic bottles have plastic fibers in them... so you're drinking plastic"),
                Challenge(title: "Use Metal Straw", image: "metalStraw", coin: "70", challengeDetail: "One way to help reduce the effect that plastic is having on the environment is to forego a plastic straw and use a metal one instead. here are some key reason :\n \n1. Safe and Durable \n2. Easy to clean \n3. Portable and Reusable \n4. Eco-Friendly \n5. Decreasing the needs for landfill"),
                Challenge(title: "Use Shopping Bag", image: "shoppingBag", coin: "100", challengeDetail: "Rather than collecting an abundance of single use plastic bags that are not only inconvenient, but harmful to the environment and costly, try using a reusable shopping bag. There are plenty of benefits to investing a reusable bag :\n \n1. Save Resources and therefore, Money! \n2. More durable and reliable \n3.  Less Plastics in Landfills \n4. De-clutter your house and save space \n5. Because you can do it to save environment!"),
                Challenge(title: "Bring Your Cutleries", image: "cutleries", coin: "200", challengeDetail: "If you are using disposable utensils, you are wasting oil, cutting trees, burning waste and causing global warming. You can stop this today. here are some key reason :\n \n1. Bringing Your Own Cutlery Can Help the Plastic Problem \n2. Zero disposable utensils means zero extra waste \n3. Reusable \n4. saving money \n5. Save The environment"),
                Challenge(title: "Sort Your waste", image: "otherOrganic", coin: "500", challengeDetail: "Doing separate collection is an action that has become part of our daily life; with a bit of organization, even if we have little space, differentiating becomes a good habit. and this is the benefit : \n\n1. To reduce waste taken to landfill \n2. It’ll save you from additional expenses \n3. Save spaces on waste sites \n4. take advantage of the resources in the recycled material \n5. You can make money from your recyclable trash!\n Precondition: \nProvide different waste baskets to separate types of waste")]
    }
}


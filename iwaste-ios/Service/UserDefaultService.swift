//
//  UserDefaultService.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 19/10/20.
//

import Foundation

class UserDefaultService {
    static let instance = UserDefaultService()
    
    private let def = UserDefaults.standard
    
    fileprivate let isFirstLaunchedKey = "welcomeShown"
    fileprivate let isTargetSetKey = "isTargetSetKey"
    
    fileprivate let levelKey = "levelKey"
    fileprivate let achievementArrayKey = "achievementArrayKey"
    fileprivate let coinKey = "coinKey"
    fileprivate let badgeObtainedDateArrayKey = "badgeObtainedDateArrayKey"
    
    var isFirstLaunched: Bool {
        get {
            return def.bool(forKey: isFirstLaunchedKey)
        }
        set {
            def.set(newValue, forKey: isFirstLaunchedKey)
        }
    }
    
    var isTargetSet: Bool {
        get {
            return def.bool(forKey: isTargetSetKey)
        }
        set {
            def.set(newValue, forKey: isTargetSetKey)
        }
    }
    
    //MARK: - Achievement Section
    var level: String {
        get {
            return def.string(forKey: levelKey) ?? ""
        }
        set {
            def.set(newValue, forKey: levelKey)
        }
    }
    
    var achievementArray: [Int] {
        get {
            return def.array(forKey: achievementArrayKey) as? [Int] ?? [Int]()
        }
        set {
            def.set(newValue, forKey: achievementArrayKey)
        }
    }
    
    var badgeObtainedDateArray: [Date] {
        get {
            return def.array(forKey: badgeObtainedDateArrayKey) as? [Date] ?? [Date]()
        }
        set {
            def.set(newValue, forKey: badgeObtainedDateArrayKey)
        }
    }
    
//    var coin: Int {
//        get {
//            return def.integer(forKey: coinKey)
//        }
//        set {
//            def.set(newValue, forKey: coinKey)
//        }
//    }
}

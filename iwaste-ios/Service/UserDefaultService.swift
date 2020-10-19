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
}

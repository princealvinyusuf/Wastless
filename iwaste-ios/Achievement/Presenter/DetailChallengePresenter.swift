//
//  DetailChallengePresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/11/20.
//

import Foundation

protocol DetailChallengeDelegate {
    func upgradeLevel(bool: Bool)
}

class DetailChallengePresenter {
    fileprivate var udService = UserDefaultService.instance
    
    var delegate: DetailChallengeDelegate
    
    init(delegate: DetailChallengeDelegate) {
        self.delegate = delegate
    }
    
    func doneChallenge(at position: Int) {
        let arrayChallenge = Challenge.createChallenge()
        let level = Level(rawValue: udService.level)
        
        if position < arrayChallenge.count-1 {
            _ = arrayChallenge[position]
            _ = arrayChallenge[position+1]
            
            udService.achievementArray.append(position)
            
            var arrayMatchesInt = [Int]()
            for (i, c) in arrayChallenge.enumerated() {
                if c.level == level {
                    arrayMatchesInt.append(i)
                }
            }
            
            var isExit = false
            arrayMatchesInt.forEach { (num) in
                if !udService.achievementArray.contains(num) {
                    isExit = true
                }
            }

            if isExit {
                delegate.upgradeLevel(bool: false)
                return
            } else {
                upgradeLevel()
                delegate.upgradeLevel(bool: true)
            }
            
        } else {
            udService.achievementArray.append(position)
            upgradeLevel()
            delegate.upgradeLevel(bool: true)
        }
    }
    
    fileprivate func upgradeLevel() {
        let level = Level(rawValue: udService.level)
        switch level {
        case .novice:
            udService.level = Level.ecoStarter.rawValue
            break
        case .ecoStarter:
            udService.level = Level.ecoFriendly.rawValue
            break
        default:
            udService.level = Level.ecoMaster.rawValue
            break
        }
    }
}

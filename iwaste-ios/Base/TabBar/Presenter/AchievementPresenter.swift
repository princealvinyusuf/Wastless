//
//  AchievementPresenter.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 01/11/20.
//

import Foundation

class AchievementPresenter {
    fileprivate var udService = UserDefaultService.instance
    
    func loadDataLevel(completion: @escaping(_ modelLevel: ModelLevel, _ currentProgress: Int) -> ()) {
        let level = Level(rawValue: udService.level)
        let dataLevel = getDataLevel(level: level ?? .novice)
        
        completion(dataLevel, numPointProgress)
    }
    
    private var numPointProgress: Int {
        get {
            var progress = 0
            let arrayCompletedAchievement = udService.achievementArray
            
            let level = Level(rawValue: udService.level)
            let dataLevel = getDataLevel(level: level ?? .novice)
            
            let dataChallenge = Challenge.createChallenge()
            
            if !arrayCompletedAchievement.isEmpty {
                arrayCompletedAchievement.forEach { (num) in
                    progress += dataChallenge[num].point
                }
            }
            
            if progress >= dataLevel.minPoint {
                progress -= dataLevel.minPoint
            }
            
            return progress
        }
    }
}

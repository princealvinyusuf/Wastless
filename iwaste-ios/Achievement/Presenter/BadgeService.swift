//
//  BadgeService.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 04/11/20.
//

import UIKit
import CoreData

class BadgeService {
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let udService = UserDefaultService.instance
    
    static func isBadgeComplete() -> Bool {
        let dataTrash = configureTrashData()
        if dataTrash.isWeekChanging {
            if isMissionBadgeCompleted(count: dataTrash.trashCount) {
                udService.badgeObtainedDateArray.append(Date())
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    // 1. Get all trashes data from database
    static func getAllTrashesData(_ date: Date? = nil) -> [TrashCD] {
        var trashes = [TrashCD]()
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let trashRequest: NSFetchRequest<TrashCD> = TrashCD.fetchRequest()
            
            if let date = date {
                let datePredicate = NSPredicate(format: "date=%@", dateToString(date))
                trashRequest.predicate = datePredicate
            }
            
            do {
                try trashes = managedContext.fetch(trashRequest)
            } catch {
                print("error get trash data: ", error.localizedDescription)
            }
        }
        
        return trashes
    }
    
    // 2. Configure if week changing or not and get trash count for each date
    static func configureTrashData() -> (isWeekChanging: Bool, trashCount: Int) {
        var isChanging = false
        var count = 0
        
        var arrayDates = [Date]()
        let trashesData = getAllTrashesData()
        
        for data in trashesData {
            let trashDate = stringToDate(data.date!)
            if !arrayDates.contains(trashDate) {
                arrayDates.append(trashDate)
            }
        }
        
        var weekFromDate = [Int]()
        arrayDates.forEach { (date) in
            weekFromDate.append(date.week)
            // Potential bug here is when last week data only store one day then its still count as a week
            if weekFromDate.count > 1 {
                if weekFromDate.last != weekFromDate.first {
                    isChanging = true
                } else {
                    count += getAllTrashesData(date).count
                }
            }
        }
        
        return (isChanging, count)
    }
    
    // 3. Determine if badge mission is complete
    static func isMissionBadgeCompleted(count: Int) -> Bool {
        let arrayObtainedBadges = udService.badgeObtainedDateArray
        let arrayBadges = Badges.createBadges()

        var pos = 0
        if !arrayObtainedBadges.isEmpty {
            pos = arrayObtainedBadges.count
        }
        
        if pos > arrayBadges.count-1 {
            return false
        }
        
        let targetBadge = arrayBadges[pos]
        
        var arrayAchPos = [Int]()
        for i in 0...udService.achievementArray.count {
            arrayAchPos.append(i)
        }
        
        for num in targetBadge.missionChallenge {
            if !arrayAchPos.contains(num) {
                return false
            }
        }
        
        if targetBadge.missionBin >= count {
            return true
        } else {
            return false
        }
    }
    
    static func stringToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ("dd/MM/yyyy")
        
        return dateFormatter.date(from: string)!
    }
    
    static func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ("dd/MM/yyyy")
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
}

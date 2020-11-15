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
            var isBadgeComplete = false
            var orderBadge = 99
            for (k, v) in determineCompletionBadge(count: dataTrash.trashCount) {
                isBadgeComplete = v
                orderBadge = k
            }
            
            if isBadgeComplete == true {
                if orderBadge < 99 {
                    BadgeDataFunction.saveBadgeData(num: orderBadge, date: Date())
                    return true
                } else {
                    return false
                }
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
    static func determineCompletionBadge(count: Int) -> [Int:Bool] {
        var badgeOrder = 0
        if count >= 40 && count < 50 {
            badgeOrder = 0
        } else if count >= 30 && count < 40 {
            badgeOrder = 1
        } else if count >= 20 && count < 30 {
            badgeOrder = 2
        } else if count < 20 {
            badgeOrder = 3
        } else {
            badgeOrder = 99
        }
        
        var isComplete = false
        if badgeOrder < 99 {
            isComplete = true
        }
        
        return [badgeOrder: isComplete]
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
    
    static func isContain(num: Int) -> Bool {
        let arrayBadge = BadgeDataFunction.retrieveAllBadgeData()
        var dataNum = [Int]()
        arrayBadge.forEach { (badge) in
            dataNum.append(badge.num)
        }
        
        if dataNum.contains(num) {
            return true
        } else {
            return false
        }
    }
    
    static func timesOfAchieve(num: Int, completion: @escaping (_ numOfTimes: Int, _ latestDate: Date) -> ()) {
        let arrayDataBadges = BadgeDataFunction.retrieveAllBadgeData()
        
        var numTimes = 0
        arrayDataBadges.forEach { (badge) in
            if badge.num == num {
                numTimes += 1
            }
        }
        
        let mostRecent = arrayDataBadges.reduce(arrayDataBadges[0], { $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 ? $0 : $1 })
        
        completion(numTimes, mostRecent.date)
    }
}

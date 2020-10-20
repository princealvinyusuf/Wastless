//
//  TrashCD+CoreDataProperties.swift
//  iwaste-ios
//
//  Created by Muhammad Raihan on 21/10/20.
//
//

import Foundation
import CoreData


extension TrashCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrashCD> {
        return NSFetchRequest<TrashCD>(entityName: "TrashCD")
    }

    @NSManaged public var type: Int64
    @NSManaged public var name: String?
    @NSManaged public var count: Int64
    @NSManaged public var date: Date?

}

extension TrashCD : Identifiable {

}

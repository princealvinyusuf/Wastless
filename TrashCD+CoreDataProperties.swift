//
//  TrashCD+CoreDataProperties.swift
//  iwaste-ios
//
//  Created by Muhammad Raihan on 01/11/20.
//
//

import Foundation
import CoreData


extension TrashCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrashCD> {
        return NSFetchRequest<TrashCD>(entityName: "TrashCD")
    }

    @NSManaged public var count: Int64
    @NSManaged public var date: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?

}

extension TrashCD : Identifiable {

}

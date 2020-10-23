//
//  CategoryCD+CoreDataProperties.swift
//  iwaste-ios
//
//  Created by Muhammad Raihan on 24/10/20.
//
//

import Foundation
import CoreData


extension CategoryCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCD> {
        return NSFetchRequest<CategoryCD>(entityName: "CategoryCD")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var target: Int64

}

extension CategoryCD : Identifiable {

}

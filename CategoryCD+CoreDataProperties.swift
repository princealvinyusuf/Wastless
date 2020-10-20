//
//  CategoryCD+CoreDataProperties.swift
//  iwaste-ios
//
//  Created by Muhammad Raihan on 21/10/20.
//
//

import Foundation
import CoreData


extension CategoryCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCD> {
        return NSFetchRequest<CategoryCD>(entityName: "CategoryCD")
    }

    @NSManaged public var name: String?
    @NSManaged public var target: Int64
    @NSManaged public var date: Date?

}

extension CategoryCD : Identifiable {

}

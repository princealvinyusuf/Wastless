//
//  CategoryCD+CoreDataProperties.swift
//  iwaste-ios
//
//  Created by Muhammad Raihan on 01/11/20.
//
//

import Foundation
import CoreData


extension CategoryCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCD> {
        return NSFetchRequest<CategoryCD>(entityName: "CategoryCD")
    }

    @NSManaged public var date: String?
    @NSManaged public var name: String?
    @NSManaged public var target: Int64

}

extension CategoryCD : Identifiable {

}

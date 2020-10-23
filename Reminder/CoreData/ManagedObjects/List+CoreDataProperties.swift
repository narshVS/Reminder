//
//  List+CoreDataProperties.swift
//  Reminder
//
//  Created by Влад Овсюк on 23.10.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var descriptionNote: String?
    @NSManaged public var id: Int64
    @NSManaged public var listName: String?
    @NSManaged public var title: String?

}

extension List : Identifiable {

}

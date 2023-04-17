//
//  Record+CoreDataProperties.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/7/23.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var unit_amount: Double
    @NSManaged public var note: String?
    @NSManaged public var habit: Increment_Habit?
    
    public var unwrapped_date: Date {
        date ?? .now
    }

}

extension Record : Identifiable {

}

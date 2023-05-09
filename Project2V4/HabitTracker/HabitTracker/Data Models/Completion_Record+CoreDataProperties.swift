//
//  Completion_Record+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/8/23.
//
//

import Foundation
import CoreData


extension Completion_Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Completion_Record> {
        return NSFetchRequest<Completion_Record>(entityName: "Completion_Record")
    }

    @NSManaged public var is_completed: Bool
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var boolean_habit: Boolean_Habit?
    
    public var unwrapped_cr_date: Date {
        date ?? .now
    }
    
}

extension Completion_Record : Identifiable {

}

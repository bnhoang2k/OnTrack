//
//  Boolean_Habit+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/8/23.
//
//

import Foundation
import CoreData


extension Boolean_Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Boolean_Habit> {
        return NSFetchRequest<Boolean_Habit>(entityName: "Boolean_Habit")
    }

    @NSManaged public var note: String?
    @NSManaged public var completion_records: NSSet?
    
    public var cr_array: [Completion_Record] {
        let cr_set = completion_records as? Set<Completion_Record> ?? []
        return cr_set.sorted {
            $0.unwrapped_cr_date > $1.unwrapped_cr_date
        }
    }
    
}

// MARK: Generated accessors for completion_records
extension Boolean_Habit {

    @objc(addCompletion_recordsObject:)
    @NSManaged public func addToCompletion_records(_ value: Completion_Record)

    @objc(removeCompletion_recordsObject:)
    @NSManaged public func removeFromCompletion_records(_ value: Completion_Record)

    @objc(addCompletion_records:)
    @NSManaged public func addToCompletion_records(_ values: NSSet)

    @objc(removeCompletion_records:)
    @NSManaged public func removeFromCompletion_records(_ values: NSSet)

}

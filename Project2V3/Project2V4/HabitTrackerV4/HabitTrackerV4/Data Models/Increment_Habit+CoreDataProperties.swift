//
//  Increment_Habit+CoreDataProperties.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/7/23.
//
//

import Foundation
import CoreData


extension Increment_Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Increment_Habit> {
        return NSFetchRequest<Increment_Habit>(entityName: "Increment_Habit")
    }

    @NSManaged public var accrued_units_today: Double
    @NSManaged public var goal_value: Double
    @NSManaged public var unit_type: String?
    @NSManaged public var record: NSSet?
    
    public var unwrapped_name: String {
        name ?? "Unknown Name"
    }
    
    public var unwrapped_unit_type: String {
        unit_type ?? "Unknown Type"
    }
    
    public var records_array: [Record] {
        let record_set = record as? Set<Record> ?? []
        
        return record_set.sorted {
            $0.unwrapped_date > $1.unwrapped_date
        }
    }
    
}

// MARK: Generated accessors for record
extension Increment_Habit {

    @objc(addRecordObject:)
    @NSManaged public func addToRecord(_ value: Record)

    @objc(removeRecordObject:)
    @NSManaged public func removeFromRecord(_ value: Record)

    @objc(addRecord:)
    @NSManaged public func addToRecord(_ values: NSSet)

    @objc(removeRecord:)
    @NSManaged public func removeFromRecord(_ values: NSSet)

}

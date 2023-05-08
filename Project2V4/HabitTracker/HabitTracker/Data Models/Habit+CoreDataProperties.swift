//
//  Habit+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/3/23.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var date: Date?
    @NSManaged public var habit_type: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    
    public var unwrapped_name: String {
        name ?? "name error"
    }
    
}

extension Habit : Identifiable {

}

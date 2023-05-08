//
//  Boolean_Habit+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/7/23.
//
//

import Foundation
import CoreData


extension Boolean_Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Boolean_Habit> {
        return NSFetchRequest<Boolean_Habit>(entityName: "Boolean_Habit")
    }

    @NSManaged public var is_completed: Bool
    @NSManaged public var note: String?
    @NSManaged public var sub_habits: Boolean_Habit?

}

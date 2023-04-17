//
//  Habit+CoreDataProperties.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/7/23.
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

}

extension Habit : Identifiable {

}

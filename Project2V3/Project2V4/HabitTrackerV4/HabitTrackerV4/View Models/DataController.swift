//
//  DataController.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/14/23.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    
    let habit_container = NSPersistentContainer(name: "HabitDataModel")
    
    init() {
        habit_container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data. \(error.localizedDescription)")
            }
        }
    }
    
    func save (context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved succesfully.")
        } catch {
            print("Error saving data.")
        }
    }
    
    // Increment Habit
    func add_habit (name: String, type: habit_type, goal_value: Double, unit_type: String, context: NSManagedObjectContext) {
        
        let new_habit = Increment_Habit(context: context)
        new_habit.name = name
        new_habit.id = UUID()
        new_habit.habit_type = type.rawValue
        new_habit.date = Date()
        
        new_habit.goal_value = goal_value
        new_habit.unit_type = unit_type
        
        save(context: context)
    }
    
    func add_record(inc_habit: Increment_Habit, unit_amount: Double, context: NSManagedObjectContext) {
        
        let new_record = Record(context: context)
        new_record.date = Date()
        new_record.id = UUID()
        new_record.unit_amount = unit_amount
        
        inc_habit.addToRecord(new_record)
        
        save(context: context)
        
    }
    
    func edit_record(record: Record, unit_amount: Double, date: Date, context: NSManagedObjectContext) {
        
        record.unit_amount = unit_amount
        record.date = date
        
        save(context: context)
        
    }
    
}

public extension NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
        
    }
    
}

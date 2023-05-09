//  DataController.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/14/23.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    
    let habit_container = NSPersistentContainer(name: "HabitTracker")
    
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
    
}

extension DataController {
    // Constructors
    
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
    // Boolean Habit
    func add_habit (name: String, type: habit_type, note: String, context: NSManagedObjectContext) {
        let new_habit = Boolean_Habit(context: context)
        new_habit.name = name
        new_habit.id = UUID()
        new_habit.habit_type = type.rawValue
        new_habit.date = Date()
        
        // Basically habit description
        new_habit.note = note
        
        save(context: context)
    }
}

extension DataController {
    // More functionality
    
    // Edit Increment Habit
    func edit_habit(increment_habit: Increment_Habit, new_name: String, new_goal_value: Double, new_unit_type: String, context: NSManagedObjectContext) {
        increment_habit.name = new_name
        increment_habit.goal_value = new_goal_value
        increment_habit.unit_type = new_unit_type
        
        save(context: context)
    }
    func edit_habit(boolean_habit: Boolean_Habit, new_name: String, new_note: String, context: NSManagedObjectContext) {
        boolean_habit.name = new_name
        boolean_habit.note = new_note
        save(context: context)
    }
    
    func add_record(increment_habit: Increment_Habit, unit_amount: Double, curr_time: Date, note: String, context: NSManagedObjectContext) {
        let new_record = Record(context: context)
        new_record.date = curr_time
        new_record.id = UUID()
        new_record.unit_amount = unit_amount
        new_record.note = note
        
        increment_habit.addToRecord(new_record)
        
        save(context: context)
    }
    
    func edit_record(record: Record, unit_amount: Double, date: Date, note: String, context: NSManagedObjectContext) {
        record.unit_amount = unit_amount
        record.date = date
        record.note = note
        save(context: context)
    }
    
    func add_record(boolean_habit: Boolean_Habit, context: NSManagedObjectContext) {
        let new_cr = Completion_Record(context: context)
        new_cr.date = Date()
        new_cr.id = UUID()
        new_cr.is_completed = false
        
        boolean_habit.addToCompletion_records(new_cr)
        save(context: context)
    }
    
    // Toggle Is_Completed
    func iscompleted_toggle(cr: Completion_Record, is_complete: Bool, context: NSManagedObjectContext) {
        
        cr.is_completed = is_complete
        
        save(context: context)
    }
    
    func edit_cr(cr: Completion_Record, date: Date, is_completed: Bool, context: NSManagedObjectContext) {
        cr.date = date
        cr.is_completed = is_completed
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

//
//  DataController.swift
//  HabitTrackerV3
//
//  Created by Bryan Hoang on 4/13/23.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    
    let habit_container = NSPersistentContainer(name: "habit")
    
    
    
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
            print("Data saved successfully.")
        } catch {
            print("Error saving data.")
        }
    }
    
    // Overloaded Function : Increment_Habit
    func add_habit(name: String, type: habit_type, goal_value: Double, unit_type: String, context: NSManagedObjectContext) {
        let new_habit = Increment_Habit(context: context)
        new_habit.name = name
        new_habit.id = UUID()
        new_habit.habit_type = habit_type.increment_habit.rawValue
        
        new_habit.goal_value = goal_value
        new_habit.unit_type = unit_type
        new_habit.date = Date()
        
        save(context: context)
    }
    
    func edit_habit(habit: Habit, name: String, type: habit_type, context: NSManagedObjectContext) {
        
        habit.name = name
        habit.habit_type = type.rawValue
        save(context: context)
        
    }
    
}

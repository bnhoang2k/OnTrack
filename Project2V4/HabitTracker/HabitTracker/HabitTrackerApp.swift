//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/1/23.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    
    @StateObject private var data_controller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, data_controller.habit_container.viewContext)
        }
    }
}

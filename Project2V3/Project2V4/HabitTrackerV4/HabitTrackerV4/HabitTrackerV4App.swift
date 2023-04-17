//
//  HabitTrackerV4App.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/7/23.
//

import SwiftUI

@main
struct HabitTrackerV4App: App {
    
    @StateObject private var data_controller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, data_controller.habit_container.viewContext)
        }
    }
}

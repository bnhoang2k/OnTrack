//
//  HabitTrackerV3App.swift
//  HabitTrackerV3
//
//  Created by Bryan Hoang on 4/13/23.
//

import SwiftUI

@main
struct HabitTrackerV3App: App {
    
    @StateObject private var data_controller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, data_controller.habit_container.viewContext)
        }
    }
}

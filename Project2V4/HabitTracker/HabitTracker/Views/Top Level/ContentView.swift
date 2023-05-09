//
//  ContentView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var habit_view_model = HabitViewModel()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var habits: FetchedResults<Habit>
    
    @State private var selected_habit: Habit? = nil
    
    var body: some View {
        HStack {
            NavigationSplitView {
                HabitListView(habits: habits, show_add_habit: $habit_view_model.show_add_habit, selected_habit: $selected_habit)
                    .navigationSplitViewColumnWidth(200)
            }detail: {
                if selected_habit != nil {
                    HabitViewSwitcher(curr_habit: $selected_habit, show_edit_habit: $habit_view_model.show_edit_habit, show_edit_record: $habit_view_model.show_edit_record)
                }

                else {
                    Text("Select a habit!")
                }
            }
        }
        .sheet(isPresented: $habit_view_model.show_add_habit) {
            AddHabitView()
        }
    }
}

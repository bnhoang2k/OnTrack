//
//  ContentView.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/7/23.
//

// TODO: Add edit habit functionality

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managed_obj_context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var inc_habits: FetchedResults<Increment_Habit>
    
    @State private var show_add_habit = false
    @State private var edit_state = false
    
    var body: some View {
        NavigationView {
            VStack {
                    Button("Add Habit") {
                        show_add_habit.toggle()
                }
                List {
                    ForEach(inc_habits) { inc_habit in
                        NavigationLink(destination: IncrementHabitView(inc_habit: inc_habit)) {
                            HStack {
                                VStack(alignment: .center, spacing: 6) {
                                    Text(inc_habit.unwrapped_name)
                                }
                            }
                        }
                        .contextMenu {
                            Button ("Delete Habit") {
                                self.delete_habit(habit: inc_habit)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .frame(width: 200.0, height: 400.0)
            .navigationTitle("Habits")
            .sheet(isPresented: $show_add_habit) {
                AddHabitView()
            }
        }
    }
}

extension ContentView {
    private func delete_habit(habit: Habit) {
        managed_obj_context.delete(habit)
        DataController().save(context: managed_obj_context)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

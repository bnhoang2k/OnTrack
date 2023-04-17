//
//  ContentView.swift
//  HabitTrackerV3
//
//  Created by Bryan Hoang on 4/13/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managed_obj_context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var habits: FetchedResults<Habit>
    
    @State private var show_add_habit = false;
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Habit") {
                    show_add_habit.toggle()
                }
                List {
                    ForEach(habits) { habit in
                        NavigationLink(destination: Text("XD")) {
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(habit.name!).bold()
                                }
                            }
                            
                        }  
                        .contextMenu {
                            Button ("Delete Habit") {
                                self.delete_habit(habit: habit)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
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

//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/3/23.
//

import SwiftUI

struct HabitListView: View {
    
    var habits : FetchedResults<Habit>
    @Environment(\.managedObjectContext) var moc
    @Binding var show_add_habit: Bool
    
    @Binding var selected_habit: Habit?
    
    // Boolean Habit Functionality
    @State private var is_completed: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button ("Add Habit") {
                    show_add_habit.toggle()
                }
            }
            .padding()
            List(habits, selection: $selected_habit) { curr_habit in
                HStack {
                    Text(curr_habit.unwrapped_name).lineLimit(nil)
                        .onTapGesture {
                            selected_habit = curr_habit
                        }
                        .contextMenu {
                            Button("Delete Habit") {
                                self.delete_habit(habit: curr_habit)
                            }
                        }
                    if curr_habit is Boolean_Habit {
                        Spacer()
                        Toggle("", isOn: $is_completed).onChange(of: is_completed) { _ in
                            DataController().iscompleted_toggle(boolean_habit: curr_habit as! Boolean_Habit, context: moc)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .background(.white)
    }
}

extension HabitListView {
    private func delete_habit (habit: Habit) {
        moc.delete(habit)
        DataController().save(context: moc)
    }
    
    private func move_item(source: IndexSet, destination: Int) {
        
    }
}

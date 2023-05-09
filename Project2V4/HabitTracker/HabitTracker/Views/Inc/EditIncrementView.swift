//
//  EditHabitView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/7/23.
//

import SwiftUI

struct EditHabitView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @Binding var increment_habit: Increment_Habit
    
    @State var edit_view_error: Bool = false
    
    @State var habit_name: String = ""
    @State var habit_goal_value: Double = 0.0
    @State var habit_unit_type: String = ""
    
    var body: some View {
        VStack {
            
            Text("Edit Habit")
            HStack {
                Text("Edit Name: ")
                Spacer()
                TextField(increment_habit.unwrapped_name, text: $habit_name).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Edit Unit Type: ")
                Spacer()
                TextField(increment_habit.unwrapped_unit_type, text: $habit_unit_type).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Edit Goal Value: ")
                let goal_value_string = String(format: "%.2f", increment_habit.goal_value)
                Spacer()
                TextField(goal_value_string, value: $habit_goal_value, formatter: NumberFormatter()).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Button ("OK") {
                    if (habit_name == "" || habit_unit_type == "" || habit_goal_value == 0.0) {
                        edit_view_error.toggle()
                    }
                    else if habit_name != "" && habit_unit_type != "" && habit_goal_value != 0.0 {
                        DataController().edit_habit(increment_habit: increment_habit, new_name: habit_name, new_goal_value: habit_goal_value, new_unit_type: habit_unit_type, context: moc)
                        dismiss()
                    }
                }
                
                Button("Cancel") {
                    dismiss()
                }
            }
            
        }
        .onAppear() {
            habit_name = increment_habit.unwrapped_name
            habit_goal_value = increment_habit.goal_value
            habit_unit_type = increment_habit.unwrapped_unit_type
        }
        .alert("Invalid Name, Unit Type, or Goal Value", isPresented: $edit_view_error) {
            Text("Error")
        }
        .padding()
    }
}

//struct EditHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditHabitView()
//    }
//}

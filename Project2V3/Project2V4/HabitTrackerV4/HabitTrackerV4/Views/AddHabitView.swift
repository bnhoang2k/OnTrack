//
//  AddHabitView.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/9/23.
//

// TODO: Create an actual view controller

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.managedObjectContext) private var managed_obj_context
    @Environment(\.dismiss) var dismiss
    
    // Default Habit Vars
    @State private var name: String = ""
    @State private var selected_type: habit_type = .placeholder
    let types: [habit_type] = habit_type.allCases
    
    // Increment_Habit Vars
    @State private var goal_value: Double = 0.0
    @State private var unit_type: String = ""
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Text("Enter the name of the Habit")
                    TextField("", text: $name).frame(width: 300).multilineTextAlignment(.center)
                    Picker("Select a type", selection: $selected_type) {
                        ForEach(types, id: \.self) { type in
                            switch type {
                            case .placeholder:
                                Text("")
                            case .increment_habit:
                                Text("Increment Habit")
                            case .boolean_habit:
                                Text("Boolean Habit")
                            }
                        }
                    }
                    .frame(width: 300)
                    .pickerStyle(MenuPickerStyle())
                    if selected_type == .increment_habit {
                        HStack {
                            TextField("Enter goal value", value: $goal_value, formatter: NumberFormatter()).frame(width:150).padding()
                            TextField("Enter unit type", text: $unit_type).frame(width:150).padding()
                        }
                    }
                    HStack {
                        Button("OK") {
                            if name != "" {
                                if selected_type == .increment_habit {
                                    DataController().add_habit(name: name, type: selected_type, goal_value: goal_value, unit_type: unit_type, context: managed_obj_context)
                                }
                            }
                            dismiss()
                        }
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView()
    }
}

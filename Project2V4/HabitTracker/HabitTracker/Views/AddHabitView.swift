//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/3/23.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    // Private view variables
    // First, just those pertaining to "habit"
    @State private var name: String = ""
    @State private var type: habit_type = .placeholder
    
    // Now, those pertaining to increment habit
    @State private var goal_value = 0.0
    @State private var unit_type = ""
    
    // Boolean Habit members
    @State private var note = ""
    
    // Submit Add Habit Error Handling
    @State var show_error_view: Bool = false
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Text("Enter a new habit you want to keep track of").padding()
                    TextField("", text: $name).frame(width: 300).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
                    Picker("Select a type", selection: $type) {
                        let types: [habit_type] = habit_type.allCases
                        ForEach(types, id: \.self) { type in
                            switch type {
                            case.placeholder:
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
                    if type == .increment_habit {
                        HStack {
                            TextField("Enter a goal value", value: $goal_value, formatter: NumberFormatter()).frame(width: 150).padding()
                            TextField("Enter a unit type", text: $unit_type).frame(width: 150).padding()
                        }
                    }
                    else if type == .boolean_habit {
                        VStack {
                            Text("Habit Description")
                            Spacer()
                            TextField("", text: $note, axis: .vertical).lineLimit(5...10)
                        }
                    }
                    HStack {
                        Button("OK") {
                            if name == "" || type == .placeholder {
                                show_error_view.toggle()
                            }
                            if  type == .increment_habit && name != "" && goal_value != 0.0 && unit_type != "" {
                                DataController().add_habit(name: name, type: type, goal_value: goal_value, unit_type: unit_type, context: moc)
                                dismiss()
                            }
                            else if type == .boolean_habit && name != "" {
                                DataController().add_habit(name: name, type: type, note: note, context: moc)
                                dismiss()
                            }
                        }
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    .padding()
                }
                .padding([.trailing, .leading], 15)
            }
        }
        .alert("Error Adding Habit", isPresented: $show_error_view) {
            Text("Error")
        }
    }
}

//struct AddHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddHabitView()
//    }
//}

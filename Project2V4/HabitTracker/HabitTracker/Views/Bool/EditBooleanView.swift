//
//  EditBooleanView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/8/23.
//

import SwiftUI

struct EditBooleanView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @Binding var boolean_habit: Boolean_Habit
    
    @State var show_edit_error: Bool = false
    
    @State var habit_name: String = ""
    @State var habit_note: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Edit Name: ")
                Spacer()
                TextField(boolean_habit.unwrapped_name, text: $habit_name).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Edit Description: ")
                Spacer()
                TextField(boolean_habit.note ?? "", text: $habit_note).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            HStack {
                Button("OK") {
                    if habit_name == "" {
                        show_edit_error.toggle()
                    }
                    else {
                        DataController().edit_habit(boolean_habit: boolean_habit, new_name: habit_name, new_note: habit_note, context: moc)
                        dismiss()
                    }
                }
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .frame(width: 300)
        .padding()
        .onAppear() {
            habit_name = boolean_habit.unwrapped_name
            habit_note = boolean_habit.note ?? ""
        }
        .alert("Name cannot be empty",isPresented: $show_edit_error) {
            Text("Error")
        }
    }
}

//struct EditBooleanView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditBooleanView()
//    }
//}

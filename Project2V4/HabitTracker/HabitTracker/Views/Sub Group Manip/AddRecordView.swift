//
//  AddRecordView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/7/23.
//

import SwiftUI

struct AddRecordView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @Binding var increment_habit: Increment_Habit
    
    @State private var unit_amount: Double = 0.0
    @State private var note: String = ""
    @State private var curr_time: Date = Date()
    
    @State private var show_error_view: Bool = false
    
    var body: some View {
        VStack {
            Text ("Add a record")
            HStack {
                Text("Unit Amount: ")
                Spacer()
                TextField("", value: $unit_amount, formatter: NumberFormatter()).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            .padding(.bottom , 5)
            DatePicker("Select a time", selection: $curr_time, displayedComponents: [.hourAndMinute, .date]).frame(width: 300).multilineTextAlignment(.center).padding(.bottom, 5)
            ZStack {
                TextField("", text: $note, axis: .vertical).lineLimit(3...5)
                if note.isEmpty {
                    Text("Enter Note").multilineTextAlignment(.center).frame(width: 150).foregroundColor(.gray)
                }
            }
            .padding(.bottom, 5)
            HStack {
                Button("OK") {
                    if unit_amount == 0 {
                        show_error_view.toggle()
                    }
                    else {
                        DataController().add_record(increment_habit: increment_habit, unit_amount: unit_amount, curr_time: curr_time, note: note, context: moc)
                        dismiss()
                    }
                }
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .alert("Unit Amount cannot be 0", isPresented: $show_error_view) {
            Text("Error")
        }
        .padding()
        .padding()
    }
}

//struct AddRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRecordView()
//    }
//}

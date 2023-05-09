//
//  EditRecordView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/8/23.
//

import SwiftUI

struct EditRecordView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @Binding var edit_record: Record?
    
    @State var edit_view_error: Bool = false
    
    @State var date: Date = Date()
    @State var unit_amount: Double = 0.0
    @State var note: String = ""
    
    var body: some View {
        VStack {
            Text("Edit Record")
            HStack {
                Text("Edit Unit Amount: ")
                Spacer()
                TextField("\(edit_record!.unit_amount)", value: $unit_amount, formatter: NumberFormatter()).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            HStack {
                DatePicker("Edit Date: ", selection: $date).datePickerStyle(.compact)
            }
            HStack {
                Text("Edit Note: ")
                Spacer()
                TextField(edit_record!.note ?? "", text: $note).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            HStack {
                Button ("OK") {
                    if(unit_amount == 0.0) {
                        edit_view_error.toggle()
                    }
                    else {
                        DataController().edit_record(record: edit_record!, unit_amount: unit_amount, date: date, note: note, context: moc)
                        dismiss()
                    }
                }
                Button ("Cancel") {
                    dismiss()
                }
            }
        }
        .onAppear() {
            unit_amount = edit_record!.unit_amount
            note = edit_record!.note ?? ""
        }
        .alert("Invalid Unit Amount", isPresented: $edit_view_error) {
            Text("Error")
        }
        .padding()
    }
}

//struct EditRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRecordView()
//    }
//}

//
//  EditCRView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/8/23.
//

import SwiftUI

struct EditCRView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @Binding var selected_cr: Completion_Record?
    
    @State var cr_date: Date = Date()
    @State var is_completed: Bool = false
    
    var body: some View {
        VStack {
            Text("Edit Record")
            HStack {
                DatePicker("Edit Date", selection: $cr_date).datePickerStyle(.compact)
            }
            HStack {
                Spacer()
                Text("Is Completed?").frame(width: 100)
                Spacer()
                Toggle("", isOn: $is_completed)
                Spacer()
            }
            HStack {
                Button("OK") {
                    DataController().edit_cr(cr: selected_cr!, date: cr_date, is_completed: is_completed, context: moc)
                    print(cr_date)
                    dismiss()
                }
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .frame(width: 300)
        .padding()
        .onAppear() {
            cr_date = selected_cr!.date ?? .now
            is_completed = selected_cr!.is_completed
        }
    }
}

extension EditCRView {
    private func date_ts(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YY"
        
        return formatter.string(from: date)
    }
}

//struct EditCRView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCRView()
//    }
//}

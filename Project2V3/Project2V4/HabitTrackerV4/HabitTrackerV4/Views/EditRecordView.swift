//
//  EditRecordView.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/10/23.
//

import SwiftUI

struct EditRecordView: View {
    
    @Environment(\.managedObjectContext) var managed_obj_context
    @Environment(\.dismiss) var dismiss
    
    var record: FetchedResults<Record>.Element
    @Binding var records_changed: Bool
    
    @State var unit_amount: Double = 0.0
    @State var curr_time: Date = Date()
    
    var body: some View {
        Form {
            Section {
                VStack {
                    TextField("Enter new value", value: $unit_amount, formatter: NumberFormatter()).frame(width: 300).multilineTextAlignment(.center).onAppear {
                        unit_amount = record.unit_amount
                        curr_time = record.unwrapped_date
                    }
                    
                    DatePicker("Select a time", selection: $curr_time, displayedComponents: .hourAndMinute).frame(width: 300).multilineTextAlignment(.center)
                    
                    HStack {
                        Button("OK") {
                            if unit_amount > 0 {
                                DataController().edit_record(record: record, unit_amount: unit_amount, date: curr_time, context: managed_obj_context)
                                records_changed.toggle()
                                dismiss()
                            }
                        }
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
        .padding()
    }
}

//struct EditRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRecordView()
//    }
//}

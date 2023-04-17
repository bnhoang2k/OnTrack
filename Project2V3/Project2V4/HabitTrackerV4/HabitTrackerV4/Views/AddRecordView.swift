//
//  AddRecordView.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/10/23.
//

import SwiftUI

struct AddRecordView: View {
    
    @Environment(\.managedObjectContext) private var managed_obj_context
    @Environment(\.dismiss) var dismiss
    
    @Binding var inc_habit: FetchedResults<Increment_Habit>.Element
    @State private var unit_amount: Double = 0.0
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Text("Enter Amount").frame(width:300).multilineTextAlignment(.center)
                    TextField("", value: $unit_amount, formatter: NumberFormatter()).frame(width: 300).multilineTextAlignment(.center)
                    Text(get_current_time())
                    HStack {
                        Button("OK") {
                            if (unit_amount != 0.0){
                                
                                DataController().add_record(inc_habit: inc_habit, unit_amount: unit_amount, context: managed_obj_context)
                                
                                dismiss()
                            }
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

extension AddRecordView {
    
    private func get_current_time() -> String {
        
        let date = Date()
        
        let date_formatter = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "h:mm a"
        date_formatter.amSymbol = "AM"
        date_formatter.pmSymbol = "PM"
        
        let date_string = date_formatter.string(from: date)
        
        return date_string
        
    }
    
}

//struct AddRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRecordView()
//    }
//}

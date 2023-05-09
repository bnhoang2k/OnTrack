//
//  BooleanListView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/8/23.
//

import SwiftUI

struct BooleanListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var boolean_habit: Boolean_Habit
    @Binding var update_view: Bool
    
    @Binding var selected_record: Completion_Record?
    @Binding var show_edit_record: Bool
    
    var on_delete: () -> Void
    
    var body: some View {
        HStack {
            Text("Date").frame(width: 100)
            Spacer()
            Text("Completed?").frame(width: 100)
        }
        .padding([.leading, .trailing, .top], 10)
        List(boolean_habit.cr_array, selection: $selected_record) { cr in
            Divider()
            HStack {
                Text(date_ts(date: cr.unwrapped_cr_date)).frame(width: 100).onTapGesture {
                }.contextMenu {
                    Button("Edit Record") {
                        selected_record = cr
                        show_edit_record.toggle()
                    }
                    Button("Delete Record") {
                        delete_cr(cr: cr)
                    }
                }
                Spacer()
                if cr.is_completed {
                    Text("Completed").frame(width: 100).foregroundColor(.green)
                }
                else {
                    Text("Not Completed").frame(width: 100).foregroundColor(.red)
                }
            }
        }
        
    }
}

extension BooleanListView {
    private func date_ts(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YY"
        
        return formatter.string(from: date)
    }
    
    private func delete_cr(cr: Completion_Record) {
        moc.delete(cr)
        DataController().save(context: moc)
        on_delete()
    }
}

//struct BooleanListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooleanListView()
//    }
//}

//
//  IncrementListView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/7/23.
//

import SwiftUI

struct IncrementListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var increment_habit: Increment_Habit
    @Binding var show_edit_habit: Bool
    
    @State private var selected_record: Record?
    @Binding var show_edit_record: Bool
    
    var body: some View {
        HStack {
            Text("Unit Amount").frame(width: 100)
            Spacer()
            Text("Time Added").frame(width: 100)
            Spacer()
            Text("Note").frame(width: 200)
        }
        .padding([.leading, .trailing], 10)
        List(increment_habit.records_array, selection: $selected_record) { record in
            if Calendar.current.isDateInToday(record.unwrapped_date) {
                Divider()
                HStack {
                    let unit_amount_string = String(format: "%.2f", record.unit_amount)
                    Text(unit_amount_string + " \(increment_habit.unwrapped_unit_type)").frame(width: 100).onTapGesture {
                        selected_record = record
                    }.contextMenu {
                        Button("Edit Record") {
                            selected_record = record
                            show_edit_record.toggle()
                        }
                        Button("Delete Record") {
                            self.delete_record(record: record)
                            update_accrued()
                        }
                    }
                    Spacer()
                    Text(calc_time_since(date: record.unwrapped_date)).frame(width: 100)
                    Spacer()
                    Text(record.note ?? "").frame(width: 200).lineLimit(1)

                }
            }
        }
        .sheet(isPresented: $show_edit_record) {
            EditRecordView(edit_record: $selected_record).onDisappear(){
                update_accrued()
            }
        }
    }
}

extension IncrementListView {
    private func update_accrued() {
        increment_habit.accrued_units = 0.0
        for record in increment_habit.records_array {
            if Calendar.current.isDateInToday(record.unwrapped_date) {
                increment_habit.accrued_units += record.unit_amount
            }
        }
    }
    private func delete_record(record: Record) {
        moc.delete(record)
        DataController().save(context: moc)
    }
}

//struct IncrementListView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncrementListView()
//    }
//}

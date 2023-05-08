//
//  IncrementHabitView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/7/23.
//

import SwiftUI

struct IncrementHabitView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var increment_habit: Increment_Habit
    @Binding var show_edit_habit: Bool
    
    @State private var show_add_record: Bool = false
    
    @State private var sort_order: [KeyPathComparator<Record>] = [.init(\.unit_amount, order: .forward)]
    
    var body: some View {
        VStack {
            HStack {
                Text(increment_habit.unwrapped_name).font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5)
                
                Spacer()
                
                let accrued_units_string = String(format: "%.2f", increment_habit.accrued_units)
                
                Text(increment_habit.unwrapped_unit_type + " today: ").font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5)
                Text(accrued_units_string).font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5)
                
            }
            .padding([.leading, .trailing, .top], 15)
            Divider()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Record") {
                        show_add_record.toggle()
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            // TODO: Implement Records
            HStack {
                Text("Unit Amount")
                Spacer()
                Text("Time Added")
            }
            .padding([.leading, .trailing], 10)
//            List {
//                ForEach(increment_habit.records_array) { record in
//                    if Calendar.current.isDateInToday(record.unwrapped_date) {
//                        Divider()
//                        HStack {
//                            let unit_amount_string = String(format: "%.2f", record.unit_amount)
//                            Text(unit_amount_string + " \(increment_habit.unwrapped_unit_type)").contextMenu {
//                                Button("Delete Record") {
//                                    self.delete_record(record: record)
//                                    update_accrued()
//                                }
//                            }
//                            Spacer()
//                            Text(calc_time_since(date: record.unwrapped_date))
//
//                        }
//                    }
//                }
//            }
            Table(increment_habit.records_array) {
                TableColumn("Unit Amount", value: \.unit_amount) {
                    Text(String(format: "%.2f", $0.unit_amount))
                }
                TableColumn("Time Since Added", value: \.unwrapped_date) {
                    Text(calc_time_since(date: $0.unwrapped_date))
                }
                TableColumn("Note", value: \.note) {
                    Text($0.note ?? "")
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.white)
        .contextMenu {
            Button("Edit " + increment_habit.unwrapped_name) {
                show_edit_habit.toggle()
            }
        }
        .onAppear() {
            update_accrued()
        }
        .sheet(isPresented: $show_add_record) {
            AddRecordView(increment_habit: $increment_habit).onDisappear() {
                update_accrued()
            }
        }
        .sheet(isPresented: $show_edit_habit) {
            EditHabitView(increment_habit: $increment_habit)
        }
    }
}

extension IncrementHabitView {
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

//struct IncrementHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncrementHabitView()
//    }
//}

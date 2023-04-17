//
//  IncrementHabitView.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/9/23.
//

// TODO: EditRecordView needs to be fixed. Still not correctly updating parent view to reflect changes in the this view.

import SwiftUI

struct IncrementHabitView: View {
    
    @Environment(\.managedObjectContext) var managed_obj_context
    @State var inc_habit: Increment_Habit
    
    @State private var records: [Record]
    @State private var show_add_record = false
    @State private var show_habit_graph = false
    
    @State private var records_changed = false

    @State private var total_units_today: Double = 0.0
    
    init (inc_habit: Increment_Habit) {
        self.inc_habit = inc_habit
        self.records = inc_habit.records_array
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text(inc_habit.unwrapped_name).background(.white)
                    Spacer()
                    if total_units_today < inc_habit.goal_value {
                        
                        let total_units_string = String(format: "%.2f", total_units_today)
                        
                        (Text(total_units_string) + Text(" ") + Text(inc_habit.unit_type!) + Text(" (Today)")).background(.red)
                    }
                    else {
                        
                        let total_units_string = String(format: "%.2f", total_units_today)
                        
                        (Text(total_units_string) + Text(" ") + Text(inc_habit.unit_type!) + Text(" (Today)")).background(.green)
                    }
                    Spacer()
                    Button ("Add Record") {
                        show_add_record.toggle()
                    }
                    Spacer()
                    Button ("Show today's graph") {
                        show_habit_graph.toggle()
                    }
                    Spacer()
                }
                .onAppear(){
                    calc_total(total_units: $total_units_today)
                }
                .padding()
                List {
                    ForEach(inc_habit.records_array) { record in
                        if Calendar.current.isDateInToday(record.unwrapped_date) {
                            NavigationLink(destination: EditRecordView(record: record, records_changed: $records_changed)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        let formatted_unit_amount = String(format: "%.2f", record.unit_amount)
                                        Text(formatted_unit_amount) + Text(" ") + Text(inc_habit.unit_type!)
                                    }
                                    Spacer()
                                    Text(calc_time_since(date: record.unwrapped_date))
                                }
                            }
                            .contextMenu {
                                Button("Delete Record") {
                                    self.delete_record(record: record)
                                    calc_total(total_units: $total_units_today)
                                    
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .frame(width: 700, height: 400)
            .sheet(isPresented: $show_add_record, onDismiss: call_calc_total) {
                AddRecordView(inc_habit: $inc_habit)
            }
            .sheet(isPresented: $show_habit_graph) {
                IncrementHabitGraph(inc_habit: $inc_habit)
            }
        }
    }
}

extension IncrementHabitView {
    
    private func call_calc_total () {
        calc_total(total_units: $total_units_today)
    }
    
    private func calc_total(total_units: Binding<Double>) {
        total_units_today = 0.0
        for record in inc_habit.records_array {
            if Calendar.current.isDateInToday(record.unwrapped_date) {
                total_units_today += record.unit_amount
            }
        }
    }
    
    private func delete_record(record: Record) {
        managed_obj_context.delete(record)
        DataController().save(context: managed_obj_context)
    }
}

//struct IncrementHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncrementHabitView()
//    }
//}

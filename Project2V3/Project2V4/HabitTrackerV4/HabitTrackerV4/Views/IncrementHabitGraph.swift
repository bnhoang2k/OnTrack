//
//  IncrementHabitGraph.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/14/23.
//

// TODO: Implement another line on top of this one that calculates the total across the entire day.

import SwiftUI
import Charts

struct IncrementHabitGraph: View {
    
    @Environment(\.managedObjectContext) private var managed_obj_context
    @Environment(\.dismiss) var dismiss
    
    @Binding var inc_habit: FetchedResults<Increment_Habit>.Element
    
    @State private var total_sum: Double = 0.0
    
    var body: some View {
        VStack {
            Chart {
                ForEach(inc_habit.records_array) { record in
                    if Calendar.current.isDateInToday(record.unwrapped_date){
                        LineMark(x: .value("hour", record.unwrapped_date), y: .value("unit amount", record.unit_amount))
                    }
                }
            }
            .chartXAxisLabel("Time")
            .chartYAxisLabel(inc_habit.unwrapped_unit_type)
            .frame(width: 700, height: 400)
            .padding()
            HStack {
                Button("Close") {
                    dismiss()
                }
            }
        }
        .padding()
    }
}

extension IncrementHabitGraph {
    
    private func calc_total_so_far(record: Record) {
        if Calendar.current.isDateInToday(record.unwrapped_date) {
            total_sum += record.unit_amount
        }
    }
    
}

//struct IncrementHabitGraph_Previews: PreviewProvider {
//    static var previews: some View {
//        IncrementHabitGraph()
//    }
//}

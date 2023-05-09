//
//  IncrementGraphView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/7/23.
//

import SwiftUI
import Charts

struct IncrementGraphView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var increment_habit: Increment_Habit
    
    var body: some View {
        VStack {
            Chart {
                ForEach(increment_habit.records_array) { record in
                    if Calendar.current.isDateInToday(record.unwrapped_date) {
                        PointMark(x: .value("hour", record.unwrapped_date), y: .value("unit amount", record.unit_amount))
                        LineMark(x: .value("hour", record.unwrapped_date), y: .value("unit amount", record.unit_amount))
                    }
                }
            }
            .chartXAxisLabel("Time")
            .chartYAxisLabel(increment_habit.unwrapped_unit_type)
            .padding()
        }
    }
}

//struct IncrementGraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncrementGraphView()
//    }
//}

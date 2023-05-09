//
//  IncrementPastView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/8/23.
//

import SwiftUI

struct IncrementPastView: View {
    
    @Binding var increment_habit: Increment_Habit
    
    private var grouped_records: [Date:[Array<Record>.Element]] {
        Dictionary(grouping: increment_habit.records_array, by: {start_of_day(for: $0.unwrapped_date)})
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Date").frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
                Spacer()
                Text("Accrued Units").frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
            }
            List(grouped_records.keys.sorted(by: {abs($0.timeIntervalSinceNow) < abs($1.timeIntervalSinceNow)}), id: \.self) { date in
                Divider()
                HStack {
                    Text(date, style: .date).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
                    Spacer()
                    Text(String(format: "%.2f", calc_accrued(date: date))).frame(width: 150).multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
                }
            }
        }
    }
}

extension IncrementPastView {
    private func start_of_day(for date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
    private func calc_accrued(date: Date) -> Double {
        let start_of_day = start_of_day(for: date)
        if let records = grouped_records[start_of_day] {
            return records.reduce(0.0) { total, record in
                total + record.unit_amount
            }
        } else {
            return 0.0
        }
    }
}

//struct IncrementPastView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncrementPastView()
//    }
//}

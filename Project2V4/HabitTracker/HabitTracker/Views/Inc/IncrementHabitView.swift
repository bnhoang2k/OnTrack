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
    @Binding var show_edit_record: Bool
    
    @State private var view_selector = "table"
    @State private var show_add_record: Bool = false
    
    let view_choices = ["table", "graph", "past data"]
    
    var body: some View {
        VStack {
            HStack {
                Text(increment_habit.unwrapped_name).font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5)
                
                Spacer()
                
                let accrued_units_string = String(format: "%.2f", increment_habit.accrued_units)
                
                Text("Accrued units today: ").font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5)
                
                if increment_habit.accrued_units < increment_habit.goal_value {
                    Text(accrued_units_string).font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5)
                }
                else {
                    Text(accrued_units_string).font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5).foregroundColor(.green)
                }
                
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
            HStack {
                Picker("", selection: $view_selector) {
                    ForEach(view_choices, id: \.self) {
                        Text($0).frame(width: 100)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding([.leading, .trailing, .bottom], 10)
            
            if view_selector == "table" {
                IncrementListView(increment_habit: $increment_habit, show_edit_habit: $show_edit_habit, show_edit_record: $show_edit_record)
            }
            else if view_selector == "graph" {
                IncrementGraphView(increment_habit: $increment_habit)
            }
            else {
                IncrementPastView(increment_habit: $increment_habit)
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
            view_selector = "table"
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
}

//struct IncrementHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncrementHabitView()
//    }
//}

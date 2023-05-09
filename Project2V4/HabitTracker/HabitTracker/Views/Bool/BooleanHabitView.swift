//
//  BooleanHabitView.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/7/23.
//

import SwiftUI

struct BooleanHabitView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var boolean_habit: Boolean_Habit
    
    @State private var todays_record: Completion_Record?
    @State private var cr_iscompleted = false
    
    @State private var show_edit_habit = false
    @State private var selected_record: Completion_Record?
    @State private var show_edit_record = false
    
    @State private var streak: Int = 0
    @State private var update_view = false
    
    var body: some View {
        VStack {
            HStack {
                Text(boolean_habit.unwrapped_name).font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5)
                
                Divider().frame(height: 24)
                
                Text(String("Streak: \(streak)")).font(.system(size: 24)).bold().fixedSize().padding(.horizontal, 5)
                
                Spacer()
                
                Text(boolean_habit.note ?? "").frame(width: 100).lineLimit(3)
                
                Spacer()
                
                if cr_iscompleted {
                    Text("Completed").foregroundColor(.green).font(.system(size: 24)).bold().padding(.horizontal, 5)
                }
                else {
                    Text("Not Done").foregroundColor(.red).font(.system(size: 24)).bold().padding(.horizontal, 5)
                }
                
                Toggle("", isOn: $cr_iscompleted).onChange(of: cr_iscompleted) { _ in
                    
                    DataController().iscompleted_toggle(cr: todays_record!, is_complete: cr_iscompleted, context: moc)
                    
                    calc_streak()
                    update_view.toggle()
                    
                }
            }
            .padding([.leading, .trailing, .top], 15)
            Divider()
            BooleanListView(boolean_habit: $boolean_habit, update_view: $update_view, selected_record: $selected_record, show_edit_record: $show_edit_record, on_delete: calc_streak)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.white)
        .onAppear() {
            
            create_new_record()
            
            todays_record = boolean_habit.cr_array.first(where: {Calendar.current.isDate($0.unwrapped_cr_date, inSameDayAs: .now)})
            
            cr_iscompleted = todays_record!.is_completed
            
            calc_streak()
            
        }
        .contextMenu {
            Button("Edit " + "\(boolean_habit.unwrapped_name)") {
                show_edit_habit.toggle()
            }
        }
        .sheet(isPresented: $show_edit_record) {
            EditCRView(selected_cr: $selected_record).onDisappear() {
                create_new_record()
                calc_streak()
            }
        }
        .sheet(isPresented: $show_edit_habit) {
            EditBooleanView(boolean_habit: $boolean_habit)
        }
    }
}

extension BooleanHabitView {
    // Check the date today and the completion record.
    // If there isn't a record for today, make one.
    private func create_new_record() {
        var create_record: Bool = true
        for cr_record in boolean_habit.cr_array {
            if Calendar.current.isDateInToday(cr_record.unwrapped_cr_date) {
                create_record = false
            }
        }
        if (create_record) {
            DataController().add_record(boolean_habit: boolean_habit, context: moc)
        }
    }
    
    private func calc_streak() {
        var count:Int = 0
        for cr in boolean_habit.cr_array {
            if cr.is_completed {
                count += 1
            }
            else {
                break
            }
        }
        streak = count
    }
}

//struct BooleanHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooleanHabitView()
//    }
//}

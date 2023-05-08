//
//  HabitViewSwitcher.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/7/23.
//

import SwiftUI

struct HabitViewSwitcher: View {
    
    @Binding var curr_habit: Habit?
    @Binding var show_edit_habit: Bool
    
    var body: some View {
        if curr_habit is Increment_Habit {
            IncrementHabitView(increment_habit: Binding( get: {curr_habit as! Increment_Habit}, set: {curr_habit = $0} ), show_edit_habit: $show_edit_habit)
        }
        else if curr_habit is Boolean_Habit {
            BooleanHabitView(boolean_habit: Binding (get: {curr_habit as! Boolean_Habit}, set: {curr_habit = $0} ))
        }
    }
}

//struct HabitViewSwitcher_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitViewSwitcher()
//    }
//}

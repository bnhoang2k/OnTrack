//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/1/23.
//

import Foundation

class HabitViewModel : ObservableObject {
    
    // Sheet variables
    @Published var show_add_habit = false
    @Published var show_edit_habit = false
    @Published var show_edit_view = false
    @Published var show_add_habit_error = false
    
    @Published var selected_habit_name: String = ""
    
}

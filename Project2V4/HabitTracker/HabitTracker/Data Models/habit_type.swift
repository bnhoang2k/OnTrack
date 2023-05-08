//
//  habit_type.swift
//  HabitTracker
//
//  Created by Bryan Hoang on 5/1/23.
//

import Foundation

@objc enum habit_type : Int32, CaseIterable {
    
    case placeholder = 0
    case increment_habit = 1
    case boolean_habit = 2
    
}

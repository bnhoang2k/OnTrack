//
//  habit_type.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/7/23.
//

import Foundation

@objc enum habit_type: Int32, CaseIterable {
    
    case placeholder = 0
    case increment_habit = 1
    case boolean_habit = 2
    
}

//
//  TimeFormatter.swift
//  HabitTrackerV3
//
//  Created by Bryan Hoang on 4/14/23.
//

import Foundation

func calc_time_since(date: Date) -> String {
    
    let minutes = Int(-date.timeIntervalSinceNow)/60 // Returns seconds
    let hours = minutes / 60
    let days = hours / 24
     
    if minutes < 120 {
        return "\(minutes) minutes ago"
    }
    else if (minutes >= 120) && hours < 48 {
        return "\(hours) hours ago"
    }
    else {
        return "\(days) days ago"
    }
    
}

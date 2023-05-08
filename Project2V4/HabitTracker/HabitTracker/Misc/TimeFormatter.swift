//
//  TimeFormatter.swift
//  HabitTrackerV4
//
//  Created by Bryan Hoang on 4/7/23.
//

import Foundation

func calc_time_since(date: Date) -> String {
    
    let minutes = Int(-date.timeIntervalSinceNow)/60 // Returns seconds
    let hours = minutes / 60
    let days = hours / 24
     
    if minutes < 60 {
        return "\(minutes) minutes ago"
    }
    else if (minutes >= 60) && hours < 24 {
        return "\(hours) hours ago"
    }
    else {
        return "\(days) days ago"
    }
    
}

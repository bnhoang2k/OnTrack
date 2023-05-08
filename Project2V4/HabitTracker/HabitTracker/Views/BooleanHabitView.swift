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
    
    @State var habit_name: String = ""
    @State var habit_note: String = ""
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct BooleanHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooleanHabitView()
//    }
//}

//
//  SchedulerView.swift
//  Neuron
//
//  Created by Alvin Wu on 4/9/23.
//

import SwiftUI

struct SchedulerView: View {
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest private var Routines : FetchedResults<Routine>
    @FetchRequest private var Tasks : FetchedResults<Tasks>
    @FetchRequest private var Habits : FetchedResults<Habit>
    @FetchRequest private var Projects : FetchedResults<Project>
    
    var routineItems: [Routine]{
        Routines.compactMap({$0})
    }
    
    var taskItems : [Tasks] {
        Tasks.filter({$0.isRecurring == true})
    }
    
    var habitItems : [Habit] {
        Habits.compactMap({$0})
    }
    
    var projectItems : [Project] {
        Projects.compactMap({$0})
    }
    
    init(){
        _Routines = FetchRequest(sortDescriptors: [])
        _Tasks = FetchRequest(sortDescriptors: [])
        _Habits = FetchRequest(sortDescriptors: [])
        _Projects = FetchRequest(sortDescriptors: [])
    }
    
    var body: some View {
        LazyVStack(){
            HStack{
                Text("Today")
                    .titleFont()
                Spacer()
            }
            HStack{
                Text("This Week")
                    .titleFont()
                Spacer()
            }
            HStack{
                Text("This Month")
                    .titleFont()
                Spacer()
            }
            HStack{
                Text("This Year")
                    .titleFont()
                Spacer()
            }
        }
    }
}

struct SchedulerView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulerView()
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

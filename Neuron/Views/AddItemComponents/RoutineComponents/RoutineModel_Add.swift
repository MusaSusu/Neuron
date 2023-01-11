//
//  RoutineModel.swift
//  Neuron
//
//  Created by Alvin Wu on 12/5/22.
//

import Foundation

struct Routine_Add: Identifiable,Hashable{
    let id = UUID()
    var title : String
    var duration : TimeInterval
}

struct scheduleByDay : Hashable {
    let id = UUID()
    var name : String
    var check : Bool
    var dates : [Date]
}

let testRoutine = Routine_Add(title: "Start", duration: 0)

class RoutineModel_Add: ObservableObject{
    @Published var list : [Routine_Add] = []
    @Published var scheduleList : [scheduleByDay] = []
    
    init(){
        let calendar = Calendar.current
        let weekDays = calendar.veryShortStandaloneWeekdaySymbols
        
        //MARK: Test values
        var tempBool : Bool = false
        for item in weekDays{
            let temp = scheduleByDay(name: item, check:tempBool,dates: [Date().startOfDay()] )
            scheduleList.append(temp)
            tempBool.toggle()
        }
        self.list = [testRoutine]
    }
    
    func addRow(){
        let newRoutine = Routine_Add(title: "title", duration: 0)
        self.list.append(newRoutine)
    }
}

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
    var time : Date
    var weekdays : [Bool]
    var weekdaysCD : [String]{
        let array = Calendar.current.standaloneWeekdaySymbols
        var result : [String] = []
        for (index,item) in array.enumerated(){
            if weekdays[index] == true {
                result.append(item)
            }
        }
        return result
    }
}

let testRoutine = Routine_Add(title: "Start", duration: 0)

class RoutineModel_Add: ObservableObject{
    @Published var list : [Routine_Add] = []
    @Published var scheduleList : [scheduleByDay] = []
    
    init(){
        let temp = scheduleByDay(time: Date(timeInterval: 10*60 + 6 * 60 * 60,since: Date().startOfDay()), weekdays: .init(repeating: true, count: 7) )
        scheduleList.append(temp)
        self.list = [testRoutine]
    }
    
    func addRow(){
        let newRoutine = Routine_Add(title: "title", duration: 0)
        self.list.append(newRoutine)
    }
}

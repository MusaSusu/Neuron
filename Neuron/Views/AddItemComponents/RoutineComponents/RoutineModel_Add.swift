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
    var schedWeekChecker : [Bool] {
        weekdays.compactMap({$0 ? false : true})
    }
    var weekdaysCD : [Int16]{
        let result : [Int16] = weekdays.enumerated().compactMap({$0.element==true ? Int16($0.offset) : nil})
        return result
    }
}

#if targetEnvironment(simulator)
let testRoutine = Routine_Add(title: "Start", duration: 0)
#endif

class RoutineModel_Add: ObservableObject{
    @Published var list : [Routine_Add] = []
    @Published var scheduleList : [scheduleByDay] = []
    
    init(){
        let temp = scheduleByDay(time: Date(timeInterval: 10 * 60 + 6 * 60 * 60,since: Date().startOfDay()), weekdays: .init(repeating: true, count: 7) )
        scheduleList.append(temp)
        list.append(testRoutine)
    }
    
    func addRow(){
        let newRoutine = Routine_Add(title: "title", duration: 0)
        self.list.append(newRoutine)
    }
}
// most efficient way to store schedule and taskchecker is to only store the uncompleted dates plus convert the completed dates to a data that tracks the completion rate.




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
    var weekdaysCD : [Int16]{
        let result : [Int16] = weekdays.enumerated().compactMap({$0.element==true ? Int16($0.offset + 1) : nil})
        return result
    }
}

let testRoutine = Routine_Add(title: "Start", duration: 0)

class RoutineModel_Add: ObservableObject{
    @Published var list : [Routine_Add] = []
    @Published var scheduleList : [scheduleByDay] = []
    
    init(){
        var temp = scheduleByDay(time: Date(timeInterval: 10 * 60 + 6 * 60 * 60,since: Date().startOfDay()), weekdays: .init(repeating: true, count: 7) )
        scheduleList.append(temp)
        list.append(testRoutine)
    }
    
    func addRow(){
        let newRoutine = Routine_Add(title: "title", duration: 0)
        self.list.append(newRoutine)
    }
}

func createRoutineScedChecker(start: Date, end: Date, sched : Int) -> UInt64{
    let calender = Calendar.current
    let interval = calender.dateComponents([.weekOfYear], from: start, to: end)
    let bitSched : UInt64 = 0
    return bitSched
}

func flipBitBitSched(pos: Int, bitSched: UInt64) -> UInt64 {
    let bitIndex : UInt64 = 1 << pos
    return bitSched ^ bitIndex
}

func checkBitBitSched(pos: Int, bitSched: UInt64) -> Bool {
    let bitIndex : UInt64 = 1 << pos
    return ((bitSched & bitIndex) != 0)
}



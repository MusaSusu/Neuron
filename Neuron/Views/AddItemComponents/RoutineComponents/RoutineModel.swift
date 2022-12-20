//
//  RoutineModel.swift
//  Neuron
//
//  Created by Alvin Wu on 12/5/22.
//

import Foundation

struct Routine: Identifiable,Hashable{
    let id = UUID()
    var title : String
    var duration : TimeInterval
}

struct scheduleByDay : Hashable {
    var id : String
    var check : Bool
}

let testRoutine = Routine(title: "Start", duration: 0)

class RoutineModel: ObservableObject{
    @Published var list : [Routine] = []
    @Published var scheduleList : [scheduleByDay] = []
    
    init(){
        let weekDays : [String] = ["Sun","Mon","Tue","Wed","Thu", "Fri", "Sat"]
        //MARK: Test values
        var tempBool : Bool = false
        for item in weekDays{
            let temp = scheduleByDay(id: item, check:tempBool)
            scheduleList.append(temp)
            tempBool.toggle()
        }
        
        self.list = [testRoutine]
    }
    func addRow(){
        let newRoutine = Routine(title: "title", duration: 0)
        self.list.append(newRoutine)
    }
}

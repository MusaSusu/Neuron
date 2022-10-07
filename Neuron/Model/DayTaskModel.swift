//
//  OptionsModel.swift
//  Neuron
//
//  Created by Alvin Wu on 10/6/22.
//

import Foundation
import SwiftUI

class DayTaskModel: ObservableObject{
    
    @Published var taskStorage: [Task] = []
    
    let dateStart = "10-05-2022 12:20"
    let dateEnd = "10-05-22 13:20"

    // MARK: Task Storage
    init() {
        setStorage()
    }
    
    func setStorage(){
        taskStorage = [
            Task(taskTitle: "Wake up", taskDescription: "Wakey time",taskIcon: "sun.max", taskDateStart: "10-05-2022 09:20",taskDateEnd:"10-05-22 09:50",taskDuration: 0.5, taskColor:Color(red:0.949, green: 0.522, blue: 0)),
            Task(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  "10-05-2022 10:20",taskDateEnd: "10-05-22 11:20",taskDuration: 1,taskColor:Color(red:0.9098,green: 0.6039, blue: 0.6039)),
            Task(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: "10-05-2022 12:20",taskDateEnd:"10-05-22 13:20",taskDuration: 1,taskColor: Color(red:0.32,green: 0.62, blue: 0.81)),
            Task(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: "10-05-2022 13:20",taskDateEnd: "10-05-22 13:50",taskDuration: 0.5,taskColor: Color(red:0.467, green: 0.867,blue: 0.467)),
            Task(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop", taskDateStart: "10-05-2022 14:50",taskDateEnd: "10-05-22 15:50",taskDuration: 1, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
            Task(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt", taskDateStart: "10-05-2022 16:00",taskDateEnd: "10-05-22 17:30",taskDuration: 1.5, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
            Task(taskTitle: "Sleep", taskDescription: "Sleepytimw",taskIcon: "moon", taskDateStart:"10-05-2022 18:20",taskDateEnd: "10-05-22 19:20",taskDuration: 1, taskColor: Color(red:0.682, green: 0.776,blue: 0.812))
        ]
    }
    
    
    func extractDate(data: String) -> Date{
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "MM-dd-yyyy HH:mm"
        let returnstring = formatter4.date(from: data)
        return returnstring ?? Date.now
    }
}

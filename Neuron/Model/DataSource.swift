//
//  DataSource.swift
//  Neuron
//
//  Created by Alvin Wu on 10/8/22.
//

import Foundation
import SwiftUI

class DataSource: ObservableObject {
    
    @Published var  taskData: [String:Task] = [ : ]
    @Published var taskDataByDate: [String: [String] ] = [:]
    
    //MARK: Later on we can set this as the universal wake up time that the user can edit
    let temp:Task = Task(id:"1",taskTitle: "Wake up", taskDescription: "Wakey time",taskIcon: "pencil", taskDateStart: "10-13-2022 09:20",taskDateEnd:"10-13-2022 09:50",taskDuration: 0.5, taskColor:Color(red:0.949, green: 0.522, blue: 0),taskChecker: false)

    
    init(){
        setStorage()
        taskData[temp.id] = temp
        setByDate(data: taskData)
        sortTasksbyDate()
    }
    
    func setStorage(){
        
        func helper(data:[Task]){
            for task in data{
                taskData[task.id] = task
            }
        }
        
        let temp = [
            Task(taskTitle: "Wake up", taskDescription: "Wakey time 10-08",taskIcon: "sun.max.fill", taskDateStart: "10-16-2022 01:00",taskDateEnd:"10-16-2022 01:30",taskDuration: 0.5, taskColor:Color(red:0.949, green: 0.522, blue: 0), taskChecker: false),
            Task(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  "10-16-2022 02:00",taskDateEnd: "10-16-2022 03:00",taskDuration: 1,taskColor:Color(red:0.9098,green: 0.6039, blue: 0.6039), taskChecker: false),
            Task(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: "10-16-2022 12:20",taskDateEnd:"10-16-2022 13:20",taskDuration: 1,taskColor: Color(red:0.32,green: 0.62, blue: 0.81),taskChecker: false),
            Task(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: "10-16-2022 13:20",taskDateEnd: "10-16-2022 13:50",taskDuration: 0.5,taskColor: Color(red:0.467, green: 0.867,blue: 0.467),taskChecker: false),
            Task(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop.fill", taskDateStart: "10-16-2022 14:50",taskDateEnd: "10-16-2022 15:50",taskDuration: 1, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039),taskChecker: false),
            Task(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt.fill", taskDateStart: "10-16-2022 23:00",taskDateEnd: "10-16-2022 23:20",taskDuration: 0.33, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039),taskChecker: false),
            Task(taskTitle: "Sleep", taskDescription: "Sleepytime",taskIcon: "moon.fill", taskDateStart:"10-16-2022 23:20",taskDateEnd: "10-16-2022 23:50",taskDuration: 0.5, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039),taskChecker: false)
        ]
        
        helper(data: temp)
        
        helper(data: [
            
            Task(taskTitle: "Wake up", taskDescription: "Wakey time 10-06",taskIcon: "sun.max", taskDateStart: "10-06-2022 09:20",taskDateEnd:"10-06-2022 09:50",taskDuration: 0.5, taskColor:Color(red:0.949, green: 0.522, blue: 0),taskChecker: false),
            Task(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  "10-06-2022 10:20",taskDateEnd: "10-06-2022 11:20",taskDuration: 1,taskColor:Color(red:0.9098,green: 0.6039, blue: 0.6039),taskChecker: false),
            Task(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: "10-06-2022 12:20",taskDateEnd:"10-06-2022 13:20",taskDuration: 1,taskColor: Color(red:0.32,green: 0.62, blue: 0.81),taskChecker: false),
            Task(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: "10-06-2022 13:20",taskDateEnd: "10-06-2022 13:50",taskDuration: 0.5,taskColor: Color(red:0.467, green: 0.867,blue: 0.467),taskChecker: false),
            Task(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop", taskDateStart: "10-06-2022 14:50",taskDateEnd: "10-06-2022 15:50",taskDuration: 1, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039),taskChecker: false),
            Task(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt", taskDateStart: "10-06-2022 16:00",taskDateEnd: "10-06-2022 17:30",taskDuration: 1.5, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039),taskChecker: false),
            Task(taskTitle: "Sleep", taskDescription: "Sleepytimw",taskIcon: "moon", taskDateStart:"10-06-2022 18:20",taskDateEnd: "10-06-2022 19:20",taskDuration: 1, taskColor: Color(red:0.682, green: 0.776,blue: 0.812),taskChecker: false)
        ]
               )

    
    }
    
    func setByDate(data: [String:Task]){

        for task in data{
            let date:String = String(task.value.taskDateStart.prefix(10))
            if taskDataByDate[date] == nil {
                taskDataByDate[date] = [task.key]
            }
            else{
                taskDataByDate[date]!.append(task.key)
            }
            
        }
    }
    
    func sortTasksbyDate(){
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy HH:mm"
        for tasks in taskDataByDate{
            let array = tasks.value
            let sortedArray = array.sorted {df.date(from: taskData[$0]!.taskDateStart)! < df.date(from: taskData[$1]!.taskDateStart)!}
            taskDataByDate[tasks.key] = sortedArray
        }
    }
    
    //MARK: function to return values to create the automitically updating timeline. We need the starttime and endtime for each capsule. then we need the duration from the end time to the next task start time for the line between capsules.
    func getTimeInterval(date:String,id:String)-> (TimeInterval,TimeInterval){
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy HH:mm"
        let array:[String] = taskDataByDate[date] ?? ["1"]
        let taskIndex:Int = array.firstIndex(of: id)!
        if array.count == 1{
            return (-5,-5)
        }
        else if taskIndex == 0 {
            let nextDuration = df.date(from:taskData[id]!.taskDateEnd)!.distance(to: df.date(from: taskData[array[taskIndex+1]]!.taskDateStart )!)
            return (-5,nextDuration/2)
        }
        else if taskIndex == (array.count-1) {
            let prevDuration = df.date(from:taskData[array[taskIndex-1]]!.taskDateEnd)!.distance(to: df.date(from: taskData[id]!.taskDateStart )!)
            return (prevDuration/2,-5)
        }
        else {
            let prevDuration = df.date(from:taskData[array[taskIndex-1]]!.taskDateEnd)!.distance(to: df.date(from: taskData[id]!.taskDateStart )!)
            let nextDuration = df.date(from:taskData[id]!.taskDateEnd)!.distance(to: df.date(from: taskData[array[taskIndex+1]]!.taskDateStart )!)
            return (prevDuration/2,nextDuration/2)
        }
    }
}

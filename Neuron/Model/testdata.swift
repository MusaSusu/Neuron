//
//  testdata.swift
//  Neuron
//
//  Created by Alvin Wu on 10/7/22.
//

import Foundation

private let temp1 = [
    Task1(taskTitle: "Wake up", taskDescription: "Wakey time 10-08",taskIcon: "sun.max.fill", taskDateStart: convertDate(data: "10-17-2022 01:00"),taskDateEnd:convertDate(data: "10-17-2022 01:30"),taskDuration: 0.5, taskColor:[0.949,  0.522,  0.1], taskChecker: false),
    Task1(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  convertDate(data: "10-17-2022 02:00"),taskDateEnd: convertDate(data: "10-17-2022 03:00"),taskDuration: 1,taskColor:[0.9098, 0.6039,  0.6039], taskChecker: false),
    Task1(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: convertDate(data: "10-17-2022 12:20"),taskDateEnd:convertDate(data: "10-17-2022 13:20"),taskDuration: 1,taskColor: [0.32, 0.62,  0.81],taskChecker: false),
    Task1(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: convertDate(data: "10-17-2022 13:20"),taskDateEnd: convertDate(data: "10-17-2022 13:50"),taskDuration: 0.5,taskColor: [0.467,  0.867, 0.467],taskChecker: false),
    Task1(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop.fill", taskDateStart: convertDate(data: "10-17-2022 14:50"),taskDateEnd: convertDate(data: "10-17-2022 15:50"),taskDuration: 1, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false),
    Task1(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt.fill", taskDateStart: convertDate(data: "10-17-2022 23:00"),taskDateEnd: convertDate(data: "10-17-2022 23:20"),taskDuration: 0.33, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false),
    Task1(taskTitle: "Sleep", taskDescription: "Sleepytime",taskIcon: "moon.fill", taskDateStart:convertDate(data: "10-17-2022 23:20"),taskDateEnd: convertDate(data: "10-17-2022 23:50"),taskDuration: 0.5, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false)
]


Task(taskTitle: "Wake up", taskDescription: "Wakey time",taskIcon: "sun.max.fill", taskDateStart: "10-06-2022 09:20",taskDateEnd:"10-06-2022 09:50",taskDuration: 0.5, taskColor:Color(red:0.949, green: 0.522, blue: 0)),
Task(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil.fill", taskDateStart:  "10-06-2022 10:20",taskDateEnd: "10-06-2022 11:20",taskDuration: 1,taskColor:Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: "10-06-2022 12:20",taskDateEnd:"10-06-2022 13:20",taskDuration: 1,taskColor: Color(red:0.32,green: 0.62, blue: 0.81)),
Task(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk.fill", taskDateStart: "10-06-2022 13:20",taskDateEnd: "10-06-2022 13:50",taskDuration: 0.5,taskColor: Color(red:0.467, green: 0.867,blue: 0.467)),
Task(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop.fill", taskDateStart: "10-06-2022 14:50",taskDateEnd: "10-06-2022 15:50",taskDuration: 1, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt.fill", taskDateStart: "10-06-2022 16:00",taskDateEnd: "10-06-2022 17:30",taskDuration: 1.5, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Sleep", taskDescription: "Sleepytimw",taskIcon: "moon.fill", taskDateStart:"10-06-2022 18:20",taskDateEnd: "10-06-2022 19:20",taskDuration: 1, taskColor: Color(red:0.682, green: 0.776,blue: 0.812))

Task(taskTitle: "Wake up", taskDescription: "Wakey time",taskIcon: "sun.max.fill", taskDateStart: "10-07-2022 09:20",taskDateEnd:"10-07-2022 09:50",taskDuration: 0.5, taskColor:Color(red:0.949, green: 0.522, blue: 0)),
Task(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil.fill", taskDateStart:  "10-07-2022 10:20",taskDateEnd: "10-07-2022 11:20",taskDuration: 1,taskColor:Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: "10-07-2022 12:20",taskDateEnd:"10-07-2022 13:20",taskDuration: 1,taskColor: Color(red:0.32,green: 0.62, blue: 0.81)),
Task(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk.fill", taskDateStart: "10-07-2022 13:20",taskDateEnd: "10-07-2022 13:50",taskDuration: 0.5,taskColor: Color(red:0.467, green: 0.867,blue: 0.467)),
Task(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop.fill", taskDateStart: "10-07-2022 14:50",taskDateEnd: "10-07-2022 15:50",taskDuration: 1, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt.fill", taskDateStart: "10-07-2022 16:00",taskDateEnd: "10-07-2022 17:30",taskDuration: 1.5, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Sleep", taskDescription: "Sleepytimw",taskIcon: "moon.fill", taskDateStart:"10-07-2022 18:20",taskDateEnd: "10-07-2022 19:20",taskDuration: 1, taskColor: Color(red:0.682, green: 0.776,blue: 0.812))

Task(taskTitle: "Wake up", taskDescription: "Wakey time",taskIcon: "sun.max", taskDateStart: "10-08-2022 09:20",taskDateEnd:"10-08-2022 09:50",taskDuration: 0.5, taskColor:Color(red:0.949, green: 0.522, blue: 0)),
Task(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  "10-08-2022 10:20",taskDateEnd: "10-08-2022 11:20",taskDuration: 1,taskColor:Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: "10-08-2022 12:20",taskDateEnd:"10-08-2022 13:20",taskDuration: 1,taskColor: Color(red:0.32,green: 0.62, blue: 0.81)),
Task(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: "10-08-2022 13:20",taskDateEnd: "10-08-2022 13:50",taskDuration: 0.5,taskColor: Color(red:0.467, green: 0.867,blue: 0.467)),
Task(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop", taskDateStart: "10-08-2022 14:50",taskDateEnd: "10-08-2022 15:50",taskDuration: 1, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt", taskDateStart: "10-08-2022 16:00",taskDateEnd: "10-08-2022 17:30",taskDuration: 1.5, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Sleep", taskDescription: "Sleepytimw",taskIcon: "moon", taskDateStart:"10-08-2022 18:20",taskDateEnd: "10-08-2022 19:20",taskDuration: 1, taskColor: Color(red:0.682, green: 0.776,blue: 0.812))

Task(taskTitle: "Wake up", taskDescription: "Wakey time",taskIcon: "sun.max", taskDateStart: "10-09-2022 09:20",taskDateEnd:"10-08-2022 09:50",taskDuration: 0.5, taskColor:Color(red:0.949, green: 0.522, blue: 0)),
Task(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  "10-09-2022 10:20",taskDateEnd: "10-08-2022 11:20",taskDuration: 1,taskColor:Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: "10-09-2022 12:20",taskDateEnd:"10-08-2022 13:20",taskDuration: 1,taskColor: Color(red:0.32,green: 0.62, blue: 0.81)),
Task(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: "10-09-2022 13:20",taskDateEnd: "10-08-2022 13:50",taskDuration: 0.5,taskColor: Color(red:0.467, green: 0.867,blue: 0.467)),
Task(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop", taskDateStart: "10-09-2022 14:50",taskDateEnd: "10-08-2022 15:50",taskDuration: 1, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt", taskDateStart: "10-09-2022 16:00",taskDateEnd: "10-08-2022 17:30",taskDuration: 1.5, taskColor: Color(red:0.9098,green: 0.6039, blue: 0.6039)),
Task(taskTitle: "Sleep", taskDescription: "Sleepytimw",taskIcon: "moon", taskDateStart:"10-09-2022 18:20",taskDateEnd: "10-08-2022 19:20",taskDuration: 1, taskColor: Color(red:0.682, green: 0.776,blue: 0.812))

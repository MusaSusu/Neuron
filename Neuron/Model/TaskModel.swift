//
//  TaskModel.swift
//  Neuron
//
//  Created by Alvin Wu on 9/28/22.
//
import Foundation
import SwiftUI

// I need one view model for each view but I should have a dictionary of the tasks at the highest view hierarchy. When the app starts it, should then partition all the tasks into new view models, that are generated from the views.

struct Task: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskIcon: String
    var taskDateStart: String
    var taskDateEnd: String
    var taskDuration: CGFloat
    var taskColor: Color
    var taskChecker : Bool
}
struct Task1: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskIcon: String
    var taskDateStart: Date
    var taskDateEnd: Date
    var taskDuration: CGFloat
    var taskColor: [Double]
    var taskChecker : Bool
}

func convertDate(data: String) -> Date{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = "MM-dd-yyyy HH:mm"
    return formatter4.date(from: data) ?? Date.now
}

func convertDate1(data: String) -> Date{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = "MM-dd-yyyy"
    return formatter4.date(from: data) ?? Date.now
}

func extractDate(date: Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy HH:mm"
    return formatter.string(from:date)
}

extension View {
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
    }
}

var previewscontainer: Tasks{
    let newItem = Tasks(context: PersistenceController.preview.container.viewContext)
    newItem.id = UUID()
    newItem.title = "Wake up"
    newItem.dateStart = convertDate(data: "10-17-2022 01:00")
    newItem.dateEnd = convertDate(data: "10-17-2022 01:30")
    newItem.info = "Wakey time 10-08"
    newItem.icon = "sun.max.fill"
    newItem.duration = 0.5
    newItem.color = [0.949,  0.522,  0.1]
    newItem.completed = false
    return newItem
}

extension Array<Double>{
    func fromDouble() -> Color {
        return Color(red: self[0], green: self[1], blue: self[2])
    }
}

let userColor = Color(red: 0.5, green: 0.6039,  blue:0.8039)
let hueColors = stride(from: 0, to: 1, by: 0.01).map {
    Color(hue: $0, saturation: 1, brightness: 1)
}


    

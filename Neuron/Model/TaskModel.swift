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
    var taskDateStart: String
    var taskDateEnd: String
    var taskDuration: CGFloat
    var taskColor: [Double]
    var taskChecker : Bool
}

extension View {
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
    }
}
    

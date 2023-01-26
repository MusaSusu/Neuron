//
//  NewItemModel.swift
//  Neuron
//
//  Created by Alvin Wu on 11/13/22.
//

//MARK: Generic structure for all tasks? Task -> Subtask -> more subtasks like a tree. Assign a date to each subtask, or frequency per week, or repeat on certain times. 

import Foundation
import SwiftUI

protocol TaskProtocol{
    var name: String{get set}
    var icon: String?{get set}
    var color: Color?{get set}
}

struct anyTask: Identifiable,Hashable,TaskProtocol{
    let id = UUID()
    var name: String
    var icon: String?
    var color: Color?
}

class Node<anyTask:TaskProtocol>{
    var value: anyTask
    var children: [Node]
    weak var parent: Node?
    
    init(_ value: anyTask, children: [Node] = []) {
        self.value = value
        self.children = children
        
        for child in self.children {
            child.parent = self
        }
    }
    
    func add(child: Node) {
        child.parent = self
        children.append(child)
    }
}

enum taskDate{
    case dates
    case schedule
    case frequency
}

enum PopUp_Adder : String, Identifiable{
    case DatePop
    case RoutinePop
    case none
    
    var id: Self{self}
}


class NewItemModel: ObservableObject{
    var selection: Int = 0
    
    @Published var isPop : PopUp_Adder = .none
    
    
    @Published var name: String = ""
    @Published var icon: String = "gift.fill"
    @Published var color: Color = Color(red: 0.5, green: 0.6039,  blue:0.8039)

    @Published var dateStart: Date = Date.now
    @Published var dateEnd: Date = Date.now.advanced(by: 300)
    @Published var duration: Double = 3600

    @Published var notes: String = ""
    
    let testingnode = Node(anyTask(name: "eat lunch", icon: "dsd", color: Color.red))
}

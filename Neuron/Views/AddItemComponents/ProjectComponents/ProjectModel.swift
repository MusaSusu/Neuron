//
//  SubTaskModel.swift
//  Neuron
//
//  Created by Alvin Wu on 11/28/22.
//

import Foundation

struct SubTask: Identifiable,Hashable{
    let id = UUID()
    var title : String
    var notes : String
    var completed : Bool = false
}

class ProjectModel: ObservableObject{
    @Published var subTaskCollection: [SubTask] = []
    @Published var date: Date = Date()
    
}

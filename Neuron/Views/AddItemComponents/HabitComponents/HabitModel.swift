//
//  TaskModel.swift
//  Neuron
//
//  Created by Alvin Wu on 12/14/22.
//

import Foundation

enum timeFrame : String,CaseIterable,Identifiable {
    case Daily,Weekly,Monthly
    var id: Self {self}
}

class HabitModel_Add : ObservableObject {
    @Published var selectedFreq : CGFloat = 1
    @Published var timeFrame : timeFrame = .Daily
    
    

}

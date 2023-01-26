//
//  TimeLineModel.swift
//  Neuron
//
//  Created by Alvin Wu on 12/16/22.
//

import Foundation
import SwiftUI
import CoreData

struct TimeLineItemModel: Identifiable,Equatable,Comparable{
    static func < (lhs: TimeLineItemModel, rhs: TimeLineItemModel) -> Bool {
        return lhs.start < rhs.start
    }
    
    static func == (lhs: TimeLineItemModel, rhs: TimeLineItemModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var icon : String
    let color : Color
    var start : Double
    var duration : Double
    var offset : Double = 0
    
    init(icon:String,start: Double, duration: Double,color: Color) {
        self.icon = icon
        self.start = start
        self.duration = duration
        self.color = color
    }
    
    mutating func offset(by amount : Double){
        self.offset = amount
    }
    
    mutating func newStart(at amount : Double){
        self.start =  amount
    }
}

//
//  TimeLineModel.swift
//  Neuron
//
//  Created by Alvin Wu on 12/16/22.
//

import Foundation
import SwiftUI

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

struct DropViewDelegate: DropDelegate {
    
    var destinationItem: TimeLineItemModel
    @Binding var items: [TimeLineItemModel]
    @Binding var draggedItem: TimeLineItemModel?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        self.items = items.sorted(by: <)
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedItem {
            let fromIndex = items.firstIndex(of: draggedItem)
            if let fromIndex {
                let fromStart = items[fromIndex].start
                let toIndex = items.firstIndex(of: destinationItem)
                if let toIndex,fromIndex != toIndex {
                    withAnimation(.default) {
                        let toStart = items[toIndex].start
                        self.items[fromIndex].newStart(at: toStart)
                        self.items[toIndex].newStart(at: fromStart)
                    }
                }
            }
        }
    }
    
}

class TimeLineModel : ObservableObject {
    @Published var items : [TimeLineItemModel]
    
    init(items: [TimeLineItemModel]) {
        self.items = items
    }
    
}


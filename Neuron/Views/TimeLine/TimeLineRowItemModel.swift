//
//  TimeLineRowItemModel.swift
//  Neuron
//
//  Created by Alvin Wu on 1/14/23.
//

import Foundation
import CoreData
import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    var destinationItem: Int
    @ObservedObject var items: timelineitemsarray
    @Binding var draggedItem: Int?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        items.sortArray()
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedItem {
            let fromIndex = draggedItem
            let toIndex = destinationItem
            if fromIndex != toIndex {
                withAnimation(.easeInOut(duration: 0.3)) {
                    
                    self.items.array.swapAt(fromIndex, toIndex)
                    items.swapItems(start: fromIndex, dest: toIndex)
                    
                }
            }
        }
    }
    
}

struct timelineItemWrapper : Hashable,Identifiable,Equatable{
    
    let id : NSManagedObjectID
    let title : String
    let color : Color
    let icon : String
    var dateInterval : DateInterval
    let duration : Double
    var index : Int = 0
    var type : taskType
    
    
    init<T:isTimelineItem>(_ item: T,date: DateInterval,type: taskType) {
        self.id = item.objectID
        self.title = item.title!
        self.color = item.color!.fromDouble()
        self.icon = item.icon!
        self.dateInterval = date
        self.duration = item.duration
        self.type = type
    }
    
    mutating func updateIndex(_ newVal:Int){
        self.index = newVal
    }
}

class timelineitemsarray : ObservableObject{
    @Published var array : [(timelineItemWrapper,Binding<Bool>)]
    
    var nextDurationArray: [TimeInterval]{
        var array = [TimeInterval]()
        let temp = self.array
        let first = temp[0..<temp.endIndex].map{$0.0.dateInterval.end}
        let second = temp[1...].map{$0.0.dateInterval.start}
        for (endTime,startTime) in zip(first,second){
            array.append(startTime.timeIntervalSince(endTime))
        }
        array.append(-10)
        return array
    }
    
    init( array: [(timelineItemWrapper,Binding<Bool>)]) {
        self.array = array
    }
    
    func initIndexes(){
        for i in array.indices{
            array[i].0.updateIndex(i)
        }
    }
    
    func sortArray(){
        self.array = array.sorted(by: {$0.0.dateInterval.start < $1.0.dateInterval.start})
        initIndexes()
    }
    
    func swapItems(start: Int,dest: Int){
        let draggedStart = array[start].0.dateInterval
        let destStart = array[dest].0.dateInterval
        
        array[start].0.dateInterval = DateInterval(start: destStart.start, duration: draggedStart.duration)
        array[dest].0.dateInterval = DateInterval(start: draggedStart.start, duration: destStart.duration)
    }
    
    func getNextDuration(index: Int)-> TimeInterval{
        return nextDurationArray[index]
    }
}

protocol isTimelineItem: NSManagedObject,Identifiable{
    var id : UUID?{get}
    var color : [Double]? {get}
    var icon : String? {get set}
    var notes : String? {get}
    var title : String? {get}
    var duration : Double {get}
    var taskChecker : Bool {get set}
}


extension Tasks : isTimelineItem{
    
}

extension Routine : isTimelineItem {
}

extension Routine_Schedule {
    func getBinding(date:Int)->Binding<Bool>{
        
        let binding : Binding<Bool> = .init(get: {self.weekTracker![date]}, set: {newVal in self.weekTracker![date] = newVal})
        return binding
    }
}

typealias timelineItems = isTimelineItem



/*
class MyObserver: NSObject {
    @objc var objectToObserve: Routine_Schedule
    var observation: NSKeyValueObservation?
    
    init(object: Routine_Schedule) {
        objectToObserve = object
        super.init()
        
        observation = observe(
            \.objectToObserve.weekTracker,
             options: [.old, .new]
        ) { object, change in
            print("myDate changed from: \(change.oldValue!), updated to: \(change.newValue!)")
        }
    }
}*/



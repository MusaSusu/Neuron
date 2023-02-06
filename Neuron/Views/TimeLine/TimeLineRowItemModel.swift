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
    
    var destinationItem: TimelineItemWrapper
    @ObservedObject var itemsArray: TimelineItemsArray
    @Binding var draggedItem: TimelineItemWrapper?
    var helper = DropViewHelper.shared
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func validateDrop(info: DropInfo) -> Bool {
        return info.hasItemsConforming(to: [.plainText])
    }
    
    func performDrop(info: DropInfo) -> Bool {
        if draggedItem != nil {
            let item = helper.dragged!
            print(item.dateInterval) /// **TEST**
            itemsArray.swapItems(start: item)
            itemsArray.initIndexes()
            itemsArray.updateDurationArray()
            helper.dragged = nil
            draggedItem = nil
            return true
        }
        else{
            DispatchQueue.main.async {
                itemsArray.array = itemsArray.copyforDrop
            }
            helper.dragged = nil
            draggedItem = nil
            return false
        }
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedItem {
            if let fromIndex = itemsArray.array.firstIndex(of:  draggedItem){
                if let toIndex = itemsArray.array.firstIndex(of:  destinationItem){
                    if fromIndex != toIndex{
                        withAnimation(.easeInOut(duration: 0.4)) {
                                itemsArray.array.swapAt(fromIndex,toIndex)
                        }
                    }
                }
            }
        }
    }
}

class DropViewHelper : ObservableObject {
    static let shared = DropViewHelper()
    
    var dragged: TimelineItemWrapper?
}

struct TimelineItemWrapper : Hashable,Identifiable{
    
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

class TimelineItemsArray : ObservableObject{
    @Published var array : [TimelineItemWrapper]  = []
    @Published var nextDurationArray : [TimeInterval] = []
    /// For undoing changes for drag and drop
    var copyforDrop : [TimelineItemWrapper]  = []
    var taskCheckerDict : [TimelineItemWrapper.ID : Binding<Bool>] = [:]
    

    func calcNextDurationArray(temp: [TimelineItemWrapper]) -> [TimeInterval]{
        var array = [TimeInterval]()
        if temp.count <= 1{
            return [-10] // -10 is to indicate no tasks preceding or following
        }
        let first = temp[0..<temp.endIndex].map{$0.dateInterval.end}
        let second = temp[1...].map{$0.dateInterval.start}
        for (endTime,startTime) in zip(first,second){
            array.append(startTime.timeIntervalSince(endTime))
        }
        array.append(-10)
        return array
    }
    
    func updateDurationArray(){
        let temp = array
        self.nextDurationArray = calcNextDurationArray(temp: temp)
    }
    
    init(combinedarray: [(TimelineItemWrapper,Binding<Bool>)] ) {
        var resultarray : [TimelineItemWrapper] = []
        for item in combinedarray{
            resultarray.append(item.0)
            self.taskCheckerDict[item.0.id] = item.1
        }
        resultarray = resultarray.sorted(by: {$0.dateInterval.start < $1.dateInterval.start})
        self.nextDurationArray =  calcNextDurationArray(temp: resultarray)
        self.array = resultarray
    }
    
    func initIndexes(){
        for i in array.indices{
            array[i].updateIndex(i)
        }
    }
    
    func sortArray(){
        array = array.sorted(by: {$0.dateInterval.start < $1.dateInterval.start})
        initIndexes()
    }
    
    func swapItems(start: TimelineItemWrapper){
        
        let draggedStart = start.dateInterval.start
        let dest = copyforDrop[array.firstIndex(of: start)!] //the original location of the dragged item. The current array has the dragged item index updated to where the user has dragged it to.
        let destStart =  dest.dateInterval.start
        
        let first = (DateInterval(start: destStart, duration: start.duration))
        let second = (DateInterval(start: draggedStart, duration: dest.duration))
        
        print( self.array[array.firstIndex(of: start)!], self.array[array.firstIndex(of: dest)!]) /// **TEST**
        
        self.array[array.firstIndex(of: start)!].dateInterval = first
        self.array[array.firstIndex(of: dest)!].dateInterval = second
        print(first,second) /// **TEST**
        
    }

    func getNextDuration(at index: Int)-> TimeInterval{
        return nextDurationArray[index]
    }
}

protocol isTimelineItem: NSManagedObject,Identifiable{
    var id : UUID?{get}
    var color : [Double]? {get set}
    var icon : String? {get set}
    var notes : String? {get set}
    var title : String? {get set}
    var duration : Double {get set}
    var taskChecker : Bool {get set}
}

extension isTimelineItem{
    func getColor() -> Color {
        self.color?.fromDouble() ?? .red
    }
}

extension Tasks : isTimelineItem{
    
}

extension Routine : isTimelineItem {
    var completionRate: Double{
        get{
            let completed = self.completed
            let notCompleted = self.notCompleted?.count ?? 0
            return completed / (completed + Double(notCompleted))
        }
    }
}

extension Routine_Schedule {
    func getBinding(for date:Int)->Binding<Bool>{
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



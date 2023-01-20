//
//  TimeLineRowItemModel.swift
//  Neuron
//
//  Created by Alvin Wu on 1/14/23.
//

import Foundation
import CoreData
import Combine

class TimeLineRowItemModel<T:NSManagedObject & isTimelineItem> : ObservableObject {
    @Published var NSobj : T
    let type : Int
    var capsuleHeight : CGFloat
    
    init(NSobj: T,type: Int,height : CGFloat) {
        self.NSobj = NSobj
        self.type = type
        self.capsuleHeight = height
    }
    
}


protocol isTimelineItem: ObservableObject{
    var color : [Double]? {get}
    var dateInterval : DateInterval {get}
    var icon : String? {get}
    var notes : String? {get}
    var title : String? {get}
    var duration : Double {get}
    var taskChecker : Bool {get set}
}

extension Tasks : isTimelineItem{
}

extension Routine : isTimelineItem {
}

public let boolPublisher = PassthroughSubject<Bool, Never>()


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
}



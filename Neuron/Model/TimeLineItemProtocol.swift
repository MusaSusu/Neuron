//
//  TimeLineItemProtocol.swift
//  Neuron
//
//  Created by Alvin Wu on 1/12/23.
//

import Foundation
import SwiftUI

protocol TimeLineItem: ObservableObject {
    var timelineID : NSUUID{get}
    var title : String? {get}
    var notes : String? {get}
    var icon : String? {get}
    var duration : Double{get}
    var taskChecker : Bool{get set}
    var date : DateInterval{get}
    var color : [Double]?{get}
}

extension 


extension TimeLineItem{
    func getColor() -> Color{
        self.color?.fromDouble() ?? .red
    }
}

extension Tasks: TimeLineItem{
    
    var timelineID : NSUUID {
        get{
            return self.id! as NSUUID
        }
    }
    var date : DateInterval{
        get {
            DateInterval(start: self.dateStart ?? Date(), duration: self.duration )
        }
    }
}

extension Routine : TimeLineItem{
    var timelineID: NSUUID{
        get{
            return self.id! as NSUUID
        }
    }
    
    var date: DateInterval {
        DateInterval(start: Date(timeInterval: self.duration, since: Date().startOfDay()), duration: self.duration)
    }
    
    
}

extension Main{
    var duration: Double{
        if self.isMember(of: Tasks){
            
        }
    }
}

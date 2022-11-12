//
//  DateListModel.swift
//  Neuron
//
//  Created by Alvin Wu on 11/10/22.
//

import Foundation
import SwiftUI

struct dateItem: Identifiable,Equatable,Hashable {
    var id : Int
    var date : Date
}

struct TargetPreferenceKey: PreferenceKey {
    // 2.
    static var defaultValue: [dateItem] = []
    // 3.
    static func reduce(
        value: inout [dateItem],
        nextValue: () -> [dateItem]
    ) {
        value.append(contentsOf: nextValue())
    }
}


class DateListModel: ObservableObject{
    @Published var dates: [Date] = [] 
    var datesQueue: [Date] = []
    
    func updateDates(){
        datesQueue = datesQueue.sorted(by: {$0<$1})
        dates = datesQueue
    }
    
    func updateDateQueue(index:Int,NewDate:Date){
        self.datesQueue[index] = NewDate
    }
    
    
    func addDate(){
        datesQueue.sort(by: {$0<$1})
        let date = datesQueue.last?.advanced(by: 360) ?? Date()
        datesQueue.append(date)
        dates = []
        dates = datesQueue
    }
}

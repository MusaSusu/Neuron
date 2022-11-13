//
//  DateListModel.swift
//  Neuron
//
//  Created by Alvin Wu on 11/10/22.
//

import Foundation
import SwiftUI

struct dateItem: Identifiable,Equatable,Hashable {
    var id : UUID
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
    @Published var dates: [dateItem] = []
    @Published var addDateCheck: Bool = false
    @Published var addInboxCheck: Bool = true
    @Published var isEditOn: Bool  = true
    @Published var isPop: Bool = false
    
    func updateDates(){
        dates.sort(by: {$0.date < $1.date})
    }
    func deleteDate(item: dateItem){
        let index = dates.firstIndex(where: {$0 == item})
        dates.remove(at: index!)
        if dates.count == 0 {
            addDateCheck = false
        }
    }
    
    func addDate(){
        dates.sort(by: {$0.date < $1.date})
        let date = dates.last?.date.advanced(by: 300) ?? Date()
        dates.append(dateItem(id:UUID(),date:date))
        if dates.count > 0 {
            addDateCheck = true
        }
    }
}

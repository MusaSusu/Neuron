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

class DateListModel: ObservableObject{
    @Published var dates: [dateItem] = [dateItem(id: UUID(), date: Date())]
    @Published var addDateCheck: Bool = false
    @Published var addInboxCheck: Bool = true
    @Published var isEditOn: Bool  = true
    @Published var isPop: Bool = false
    var currentEdit: Int = 0
    
    func editItem(_ id: dateItem){
        let index = dates.firstIndex(where: {$0 == id})!
        currentEdit = index

    }
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

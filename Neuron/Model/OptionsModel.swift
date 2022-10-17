//
//  File.swift
//  Neuron
//
//  Created by Alvin Wu on 9/28/22.
//

import Foundation
import SwiftUI

class OptionsModel: ObservableObject{
    
    // MARK: Current Week Initialization
    @Published var currentWeek: [Date] = []
    @Published var today: Date = Date()
    @Published var selectedDay: Date = Date()

    
    init(){
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
            
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value:day, to:firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    
    // MARK: func for current date
    
    func isSelected(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        return calendar.isDate( selectedDay, inSameDayAs: date)
    }
        
}


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
    var prevWeek : [Date] = []
    var nextWeek : [Date] = []
    var currentWeek: [Date] = [] {
        didSet{
            let calender = Calendar.current
            nextWeek = currentWeek.map({calender.date(byAdding: .weekOfMonth,value: 1, to: $0) ?? Date()})
            prevWeek = currentWeek.map( { calender.date(byAdding:.weekOfMonth,value: -1, to: $0) ?? Date() } )
        }
    }
        
    @Published var today: Date = Date()
    @Published var selectedDay: Date = Date()
    @Published var selectedDayString: String = String()
    @Published var distance: CGFloat = CGFloat()

    init(){
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek(){
        
        let today = Date().startOfDay()
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
    
    func updateNextWeek(){
        let calendar = Calendar.current
        currentWeek = nextWeek
        selectedDay = calendar.date(byAdding: .weekOfMonth,value: 1, to: selectedDay) ?? Date()
    }
    
    func updatePrevWeek(){
        let calendar = Calendar.current
        currentWeek = prevWeek
        selectedDay = calendar.date(byAdding: .weekOfMonth,value: -1, to: selectedDay) ?? Date()
    }
    
    
    // MARK: func for current date
    
    func isSelected(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        return calendar.isDate( selectedDay, inSameDayAs: date)
    }
    
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        return formatter.string(from:date)
    }
        
}


//
//  File.swift
//  Neuron
//
//  Created by Alvin Wu on 9/28/22.
//

import Foundation
import SwiftUI


class TaskViewModel: ObservableObject{
    
    // MARK: Task Storage
    @Published var taskStorage: [Task] = [
        Task(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy", taskDate: .init(timeIntervalSince1970: 1641645497))
    ]
    
    
    // MARK: Current Week Initialization
    @Published var currentWeek: [Date] = []
    
    @Published var today: Date = Date()
    
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
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value:day, to:firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    // MARK: format current date
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from:date)
    }
    
    // MARK: func for current date
    
    func isToday(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        return calendar.isDate( today, inSameDayAs: date)
    }
        
}


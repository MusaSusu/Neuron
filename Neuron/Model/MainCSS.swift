//
//  TaskModel.swift
//  Neuron
//
//  Created by Alvin Wu on 9/28/22.
//
import Foundation
import SwiftUI// I need one view model for each view but I should have a dictionary of the tasks at the highest view hierarchy. When the app starts it, should then partition all the tasks into new view models, that are generated from the views.


//MARK: TASK FUNCTIONS -----------------------------------------------

struct Task1: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskIcon: String
    var taskDateStart: Date
    var taskDateEnd: Date
    var taskDuration: CGFloat
    var taskColor: [Double]
    var taskChecker : Bool
}

let userColor = Color(red: 0.5, green: 0.6039,  blue:0.8039)
let hueColors = stride(from: 0, to: 1, by: 0.01).map {
    Color(hue: $0, saturation: 1, brightness: 1)
}


extension Tasks{
    
    func getColor() -> Color {
        self.color?.fromDouble() ?? .red
    }
    var dateInterval : DateInterval{
        get {
            DateInterval(start: self.dateStart ?? Date(), duration: self.duration )
        }
        set{
            self.dateStart = newValue.start
            self.duration = newValue.duration
        }
    }
}

extension Routine_Schedule{
    func dateInterval(date:Date) -> DateInterval{
        let temp =  (self.time?.timeIntervalSince(self.time?.startOfDay() ?? Date())) ?? 0
        return DateInterval(start: date.addingTimeInterval(temp), duration: self.ofRoutine!.duration)
    }
}

extension Routine{
    var dateInterval: DateInterval{
        get{
            DateInterval(start: Date().startOfDay(), duration: self.duration)
        }
    }
    
    var tempsched: [(Date, [Int16])] {
        get{
            let schedules = self.schedule?.allObjects as? [Routine_Schedule]
            let days : [(Date,[Int16])] = schedules?.compactMap(
                {
                    ($0.time,($0.daysofweek?.allObjects as? [DaysOfWeek])?.compactMap({$0.weekday})) as? (Date, [Int16])
                    
                }
            ) ?? []
            return days
        }
    }
}

extension Array<Double>{
    func fromDouble() -> Color {
        return Color(red: self[0], green: self[1], blue: self[2])
    }
}


extension Color{
    func toDouble() -> [Double]{
        let comps = UIColor(self).cgColor.components
        let returnColors = comps?.map{Double($0)}
        return returnColors!
    }
}


//MARK: DATE LOGIC--------------------------------------------

func convertDate(data: String,format : String = "MM-dd-yyyy HH:mm") -> Date{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = format
    return formatter4.date(from: data) ?? Date.now
}

extension Date{
    func startOfDay() -> Date{
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
    func endOfDay() -> Date{
        let calendar = Calendar.current
        let temp = calendar.startOfDay(for: self) - 1
        return calendar.date(byAdding: .day, value: 1, to: temp) ?? Date()
    }
    func weekday() -> String{
        let weekdays = Calendar.current.weekdaySymbols
        return weekdays[Calendar.current.component(.weekday, from: self)-1]
    }
    func weekdayAsInt() -> Int16{
        Int16(Calendar.current.component(.weekday, from: self)-1)
    }
}

enum dateType : String, Identifiable {
    
    case seconds
    case minutes
    case hours
    
    var id: Self{self}
    
}

extension TimeInterval{
    func toHourMin(from type: dateType)-> String{
        var interval = self
        
        switch type {
        case .seconds:
            break
        case .minutes:
            interval = interval * 60
        case .hours:
            interval = interval * 3600
        }
        let df = DateComponentsFormatter()
        df.allowedUnits = [.hour,.minute]
        df.unitsStyle = .short
        return df.string(from: interval)!
    }
}

//MARK: OTHER STUFF ------------

extension View {
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
    }
}

var previewscontainer: Tasks{
    let newItem = Tasks(context: PersistenceController.preview.container.viewContext)
    newItem.id = UUID()
    newItem.title = "Wake up"
    newItem.dateStart = convertDate(data: "10-17-2022 01:00")
    newItem.notes = "Wakey time 10-08"
    newItem.icon = "sun.max.fill"
    newItem.duration = 0.5 * 3600
    newItem.color = [0.949,  0.522,  0.1]
    newItem.taskChecker = false
    return newItem
}

func timeElapsedInSecondsWhenRunningCode(operation: ()->()) -> Double {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return Double(timeElapsed)
}

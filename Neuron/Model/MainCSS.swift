//
//  TaskModel.swift
//  Neuron
//
//  Created by Alvin Wu on 9/28/22.
//
import Foundation
import SwiftUI
// I need one view model for each view but I should have a dictionary of the tasks at the highest view hierarchy. When the app starts it, should then partition all the tasks into new view models, that are generated from the views.


//MARK: TASK FUNCTIONS -----------------------------------------------


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
    
    /// - Returns: Array of ints from 1-7 corresponding to days of week
    func getDaysOfWeek() -> [Int] {
        guard let setDaysOfWeek = self.daysofweek?.allObjects as? [DaysOfWeek] else {
            return []
        }
        return setDaysOfWeek.compactMap({Int($0.weekday)})
    }
    
    /// - Returns: Array of count 7 corresponding to days of week
    func getSched() -> [Bool] {
        if let sched = self.weekTracker{
            return sched
        }
        return []
    }
}

extension Routine{
    var dateInterval: DateInterval{
        get{
            DateInterval(start: Date().startOfDay(), duration: self.duration)
        }
    }
        
    func getDataForTimeLineMenu() -> [(DateInterval,[Int],[Bool])] {
        guard let schedules = self.schedule?.allObjects as? [Routine_Schedule] else {return []}
        let days : [(DateInterval,[Int],[Bool])] = schedules.compactMap(
            {
                ($0.dateInterval(date: Date.now.startOfDay()),$0.getDaysOfWeek(),$0.getSched())
            }
        )
        return days
    }
}


enum taskType{
    case task
    case routine
    case habit
    case project
    case custom
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

/// Returns a `Date` type
/// - Parameters:
///   - data: Date as a `String`
///   - format: the format of `data`.  Default is `"MM-dd-yyyy HH:mm"`
/// - Returns: The data as a `Date` type
func convertDate(data: String,format : String = "MM-dd-yyyy HH:mm") -> Date{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = format
    return formatter4.date(from: data) ?? Date.now
}

let daysofweek = Calendar.current.shortStandaloneWeekdaySymbols

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
    
    /// - Returns: Returns weekday as string.
    func weekday() -> String{
        let weekdays = Calendar.current.weekdaySymbols
        return weekdays[Calendar.current.component(.weekday, from: self)-1]
    }
    
    /// Returns the weekday as an `Int` starting from Sunday as `0` and Saturday as `6`,
    func weekdayAsInt() -> Int{
        Int(Calendar.current.component(.weekday, from: self)-1)
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
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// -   :
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
        
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


#if targetEnvironment(simulator)

func timeElapsedInSecondsWhenRunningCode(operation: ()->()) -> Double {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return Double(timeElapsed)
}

var previewsTasks: Tasks{
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

var previewsRoutine: Routine{
    let viewContext = PersistenceController.preview.container.viewContext
    let newItem = Routine(context: viewContext)
    newItem.id = UUID()
    newItem.title = "Wake up"
    newItem.notes = "Wakey time 10-08"
    newItem.icon = "sun.max.fill"
    newItem.duration = 0.5 * 3600
    newItem.color = [0.949,  0.522,  0.1]
    newItem.taskChecker = false
    newItem.completed = 20
    newItem.notCompleted = .init(repeating: .now, count: 11)
    let sched = Routine_Schedule(context: viewContext)
    sched.time = Date().startOfDay().addingTimeInterval(60*60*2)
    newItem.addToSchedule(sched)
    for index in 0..<6 {
        let temp = DaysOfWeek(context: viewContext)
        temp.weekday = Int16(index)
        sched.addToDaysofweek(temp)
        sched.weekTracker = .init(repeating: false, count: 7)
    }
    return newItem
}
#endif

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

extension Main{
    func getColor() -> Color {
        self.color?.fromDouble() ?? .red
    }
}


extension Tasks{
    var dateInterval : DateInterval{
        get {
            DateInterval(start: self.dateStart ?? Date(), duration: self.duration )
        }
        set{
            self.dateStart = newValue.start
            self.duration = newValue.duration
        }
    }
    
    func getAllDates() -> [Date]{
        guard let taskDates = self.dates?.allObjects else {
            return []
        }
        return taskDates.compactMap({($0 as! TaskDate).date})
    }
}

extension Routine_Schedule{
    func dateInterval(date:Date) -> DateInterval{
        let temp =  (self.time?.timeIntervalSince(self.time?.startOfDay() ?? Date())) ?? 0
        return DateInterval(start: date.addingTimeInterval(temp), duration: self.ofRoutine!.duration)
    }
    
    /// - Returns: Array of ints from 0-6 corresponding to days of week
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
    
    func getDataForTimeLineMenu() -> [(DateInterval,[Int])] {
        guard let schedules = self.schedule?.allObjects as? [Routine_Schedule] else {return []}
        let days : [(DateInterval,[Int])] = schedules.compactMap(
            {
                let tracker = $0.getSched()
                let daysofweek = $0.getDaysOfWeek()
                var result : [Int] = .init(repeating: 0, count: 7)
                for index in daysofweek{
                    if tracker[index]{
                        result[index] = 2 //true
                    }
                    else{
                        result[index] = 1 //false
                    }
                }
                
            return ($0.dateInterval(date: Date.now.startOfDay()),result)
            }
        )
        return days
    }
    
    func initSchedforMonth(firstDayInMonth : Date) -> [Date]{
        let days : [(DateInterval,[Int])] = self.getDataForTimeLineMenu()
        var result : [Date]  = []
        
        let calendar = Calendar.current
        
        var iterStart = firstDayInMonth
        
        if firstDayInMonth.weekdayAsInt() + 1 != 1 {
            iterStart = calendar.nextDate(after: firstDayInMonth, matching: .init(weekday: 1), matchingPolicy: .previousTimePreservingSmallerComponents,direction: .backward)!
        }
        
        var lastDayofCal = calendar.dateInterval(of: .month, for: firstDayInMonth)!.end
        
        if lastDayofCal.weekdayAsInt() + 1 != 7{
            lastDayofCal = calendar.nextDate(after: lastDayofCal, matching: .init(weekday: 7), matchingPolicy: .nextTimePreservingSmallerComponents)!
        }
        
        let interval = calendar.dateComponents([.day], from: iterStart, to: lastDayofCal).day!
        
        for i in 0..<7{
            for (_,daysofweek) in days{
                if daysofweek[i] != 0{
                    var val = 0
                        while( (i + (val*7)) <=  interval  ){
                        let nextdate =  calendar.date(byAdding: .day, value: (i + (val*7)) , to: iterStart)!
                        result.append(nextdate)
                        val = (val + 1)
                    }
                }
            }
        }
        return result
    }
}

func createWeekRange(date:Date)-> [Date] {
    let calendar = Calendar.current
    let week = calendar.dateInterval(of: .weekOfMonth, for: date)
    
    guard let firstWeekDay = week?.start else {
        return []
    }
    
    var currentWeek : [Date] = []
    
    (0...6).forEach { day in
        if let weekday = calendar.date(byAdding: .day, value:day, to:firstWeekDay){
            currentWeek.append(weekday)
        }
    }
    return currentWeek
}


enum taskType{
    case Task
    case Routine
    case Habit
    case Project
    case Custom
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


struct IconView : View {
    let color : Color
    var backgroundColor : Color = .white
    let icon : String
    let dims : CGSize
    
    var body: some View{
        ZStack{
            Circle()
                .fill(color)
            Rectangle()
                .fill(backgroundColor)
                .mask{
                    Image(systemName:icon)
                        .resizeFrame(width: dims.width, height: dims.height)
                }
        }
    }
}

struct StrokeBackgroundBorder : ViewModifier{
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
    let opacity : CGFloat
    let lineWidth : CGFloat
    
    func body(content: Content) -> some View {
        content
            .background{
                RoundedRectangle(cornerRadius: 20,style: .circular)
                    .fill(Color(white: opacity), strokeBorder: userColor,lineWidth: lineWidth)
            }
    }
}

extension View{
    func backgroundStrokeBorder(opacity: CGFloat, lineWidth: CGFloat)-> some View{
        modifier(StrokeBackgroundBorder(opacity: opacity, lineWidth: lineWidth))
    }
}

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


extension Image{
    func resizeFrame(width: CGFloat,height:CGFloat)->some View{
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width,height: height)
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
    let viewContext = PersistenceController.preview.container.viewContext
    let newItem = Tasks(context: viewContext)
    newItem.id = UUID()
    newItem.title = "Wake up"
    newItem.dateStart = convertDate(data: "10-17-2022 01:00")
    newItem.notes = "Wakey time 10-08"
    newItem.icon = "sun.max.fill"
    newItem.duration = 0.5 * 3600
    newItem.color = [0.949,  0.522,  0.1]
    newItem.taskChecker = false
    let taskDate = TaskDate(context: viewContext)
    taskDate.date = convertDate(data: "10-17-2022 01:00")
    newItem.addToDates(taskDate)
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
    for index in 0..<7 {
        let temp = DaysOfWeek(context: viewContext)
        temp.weekday = Int16(index)
        sched.addToDaysofweek(temp)
        sched.weekTracker = .init(repeating: false, count: 7)
    }
    return newItem
}
#endif

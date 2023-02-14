//
//  DateCardRoutineView.swift
//  Neuron
//
//  Created by Alvin Wu on 2/6/23.
//

import SwiftUI

class CalendarDelegate : ObservableObject {
    @Published var calendars : [Int:CustomCalendar] = [:]
    var currentMonth : Int
    var currentYear : Int
    var initDate : Date
    var notCompleted : [Date]
    
    init(notCompleted : [Date],initDate : Date,month: Int,year : Int) {
        self.currentMonth = month
        self.currentYear = year
        self.initDate = initDate
        self.notCompleted = []
    }
    
    func initCal(for month: Int, year: Int,routine : Routine)-> CustomCalendar{
        let dist = month - self.currentMonth
        let newinitdate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: 35*dist, to: initDate)!
        let routine_dates = routine.initSchedforMonth(firstDayInMonth: newinitdate)
        
        calendars[month * year] = (CustomCalendar(isHighlighted: routine_dates, notCompleted: notCompleted, month: month, year: year))
        
        
        self.initDate = newinitdate
        self.currentYear = year
        self.currentMonth = month
        
        return calendars[month * year]!
    }
    
    func returnCalForView(routine : Routine,month: Int,year: Int) -> CustomCalendar {
        if let returnCal = calendars[currentYear * currentMonth] {
            return returnCal
        }
        else{
            return initCal(for: month, year: year, routine: routine)
        }
    }
}

struct DateCardRoutineView: View {
    @Environment(\.calendar) var calendar
    @ObservedObject var Routine : Routine
    @StateObject var CalDelegate : CalendarDelegate
    
    @State var month : Int
    @State var year : Int
    
    var initDate : Date {calendar.nextDate(after: .now, matching: .init(day: 1), matchingPolicy: .strict,direction: .backward)!}

    var routine_dates : [Date] {
        return Routine.initSchedforMonth(firstDayInMonth: initDate)
    }
    
    init(Routine : Routine){
        self._Routine = .init(initialValue: Routine)
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: .now)
        let month = calendar.component(.month, from: .now)
        _year = .init(initialValue: year)
        _month = .init(initialValue: month)
        let initDate = calendar.nextDate(after: .now, matching: .init(day: 1), matchingPolicy: .strict,direction: .backward)!
        let notCompleted = Routine.notCompleted ?? []
        
        _CalDelegate = .init(wrappedValue: CalendarDelegate(notCompleted: notCompleted,initDate: initDate, month: month, year: year))
    }


    
    var body: some View {
        showViewForDate()
    }
    
    @ViewBuilder
    func showViewForDate() -> some View{
        Calendar_Card_View(
            cal:CalDelegate.returnCalForView(routine: Routine, month: month, year: year),
            month: month)
    }
}

struct DateCardRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        DateCardRoutineView(Routine: previewsRoutine)
    }
}

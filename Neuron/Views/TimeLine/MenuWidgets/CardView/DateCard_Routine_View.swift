//
//  DateCardRoutineView.swift
//  Neuron
//
//  Created by Alvin Wu on 2/6/23.
//

import SwiftUI

class CalendarDelegate : ObservableObject {
    @Published var calendars : [Int:CustomCalendar] = [:]
    @Published var currentMonth : Int
    @Published var currentYear : Int
    @Published var selectedCal : CustomCalendar
    
    var initDate : Date
    var notCompleted : [Date]
    
    init(notCompleted : [Date],initDate : Date,month: Int,year : Int,routine : Routine) {
        self.currentMonth = month
        self.currentYear = year
        self.initDate = initDate
        self.notCompleted = routine.notCompleted ?? []
        let routine_dates = routine.initSchedforMonth(firstDayInMonth: initDate)
        let returnCal = (CustomCalendar(isHighlighted: routine_dates, notCompleted: notCompleted, month: month, year: year))
        selectedCal = returnCal
        calendars[year * month] = returnCal
    }
    
    func initCal(for month: Int, year: Int,routine : Routine){
        let dist = month - self.currentMonth
        let newinitdate = Calendar.autoupdatingCurrent.date(byAdding: .month, value: dist, to: initDate)!
        let routine_dates = routine.initSchedforMonth(firstDayInMonth: newinitdate)
        
        calendars[month * year] = (CustomCalendar(isHighlighted: routine_dates, notCompleted: notCompleted, month: month, year: year))
        
        
        self.initDate = newinitdate
        self.currentYear = year
        self.currentMonth = month
        
        selectedCal = calendars[month * year]!
    }
    
    func returnCalForView(routine : Routine,month: Int,year: Int) {
        if let returnCal = calendars[month * year] {
            self.selectedCal = returnCal
        }
        else{
            initCal(for: month, year: year, routine: routine)
        }
    }
}

struct DateCardRoutineView: View {
    @Environment(\.calendar) var calendar
    @ObservedObject var Routine : Routine
    @StateObject var CalDelegate : CalendarDelegate
    
    @State var date  : Date = Date()
    
    var month : Int {
        calendar.component(.month, from: date)
    }
    var year : Int {
        calendar.component(.year, from: date)
    }
    
    var titleMonth : String{
        let months = Calendar.current.monthSymbols
        return months[month-1]
    }
    
    init(Routine : Routine){
        self._Routine = .init(initialValue: Routine)
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: .now)
        let month = calendar.component(.month, from: .now)
        let initDate = calendar.nextDate(after: .now, matching: .init(day: 1), matchingPolicy: .strict,direction: .backward)!
        let notCompleted = Routine.notCompleted ?? []
        
        _CalDelegate = .init(wrappedValue: CalendarDelegate(notCompleted: notCompleted,initDate: initDate, month: month, year: year, routine: Routine))
    }
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    updateDate(left: true)
                } label: {
                    Image(systemName: "arrow.left")
                }
                Spacer()
                Text(titleMonth)
                    .font(.system(.headline,design: .monospaced,weight: .semibold))
                Spacer()
                Button{
                    updateDate(left: false)
                }label: {
                    Image(systemName: "arrow.right")
                }
            }
            .padding(.bottom,5)
            
            Calendar_Card_View(delegate: CalDelegate)
        }
    }

    
    func updateDate(left: Bool){
        if left{
            self.date = calendar.date(byAdding: .month, value: -1, to: date)!
        }
        else{
            self.date = calendar.date(byAdding: .month, value: 1, to: date)!
        }
        CalDelegate.returnCalForView(routine: Routine, month: month, year: year)
    }
}

struct DateCardRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        DateCardRoutineView(Routine: previewsRoutine)
    }
}

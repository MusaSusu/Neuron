//
//  DateCardRoutineView.swift
//  Neuron
//
//  Created by Alvin Wu on 2/6/23.
//

// Days are not being correctly filled in. Checkmark for completee. X for not compeleted and circle for upcoming days. Idea seems to be too overloaded.Uneccessary to show upcoming days like that since user can simply look at their routine schedule.

import SwiftUI

class CalendarDelegate : ObservableObject {
    @Published var calendars : [Int:CustomCalendar] = [:]
    @Published var currentMonth : Int
    @Published var currentYear : Int
    @Published var selectedCal : CustomCalendar
    var notCompleted : [Date]
    
    init(notCompleted : [Date],initDate : Date,month: Int,year : Int,routine : Routine) {
        self.currentMonth = month
        self.currentYear = year
        self.notCompleted = routine.notCompleted ?? []
        // add a unit test for this feature as the manner in which not completed days are stored could be prone to bugs. Might be easier to store the dates locally rather than calculate on start from number of days not completed since routine creation date.
        
        let returnCal = CustomCalendar( month: month, year: year)
        let routine_dates = routine.initSchedforMonth(firstDay: returnCal.firstDay, lastDay: returnCal.lastDay)
        returnCal.initCompleted(completed: routine_dates)
        selectedCal = returnCal
        calendars[year * month] = returnCal
    }
    
    func initCal(for month: Int, year: Int,routine : Routine){
        
        let newCal = CustomCalendar(month: month, year: year)
        
        let routine_dates_completed = routine.initSchedforMonth(firstDay: newCal.firstDay,lastDay: newCal.lastDay)
    
        newCal.initCompleted(completed: routine_dates_completed)
        
        calendars[month * year] = newCal
        
        self.currentYear = year
        self.currentMonth = month
        
        self.selectedCal = calendars[month * year]!
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
    
    @State var date : Date = Date()
    
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
        let initDate = calendar.nextDate(after: .now, matching: .init(day:1), matchingPolicy: .strict,direction: .backward)!
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
                Text(year.formatted())
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

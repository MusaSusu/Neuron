//
//  Calendar_Card_View.swift
//  Neuron
//
//  Created by Alvin Wu on 2/9/23.
//

import SwiftUI
import AWCalendar

class CustomCalendar : CalendarController {
    
    @Published var completed : [Date] = []
    @Published var notCompleted : [Date] = []
    
    init( month: Int,year: Int) {
        super.init(monthOf: month, yearOf: year)
    }
    
    func initCompleted(completed:[Date]){
        self.completed = completed
    }
    
    func isCompleted(date:Date)-> Bool{
       completed.contains(where: {Calendar.current.isDate($0, inSameDayAs: date)})
    }
    
    override func onTapEnd(_ day: dayComponent) {
        if isCompleted(date: day.value){
            completed.removeAll(where: {Calendar.current.isDate($0, inSameDayAs: day.value)})
        }
        else{
            completed.append(day.value)
        }
    }
}

struct Calendar_Card_View: View {
    @ObservedObject var delegate : CalendarDelegate
    
    var notCompleted : [Date]{
        let interval = DateInterval(start: delegate.selectedCal.firstDay, end: delegate.selectedCal.lastDay)
        return delegate.notCompleted.filter({interval.contains($0)})
    }
    
    var body: some View {
        VStack(spacing: 10){
            HStack(spacing: 0){
                ForEach(daysofweek.indices,id:\.self){index in
                    Text(daysofweek[index])
                        .opacity(0.5)
                        .frame(width: 40)
                    
                }
            }
            AWCalendarView(cal: delegate.selectedCal){ item in
                CalendarCell(item: item)
                    .fontWeight(.semibold)
                    .frame(width: 40,height: 40)
                    .background{
                        highlightCirc(date: item.value)
                            .frame(width: 30,height: 30)
                    }
            }
            .disabled(true)
            
            ScrollView(.vertical){
                Text(delegate.selectedCal.completed.sorted().debugDescription)
            }
            ScrollView(.vertical){
                Text(delegate.selectedCal.firstDay.debugDescription)
            }

        }
    }
    
    @ViewBuilder func highlightCirc(date:Date)->some View{
        if delegate.selectedCal.isCompleted(date: date){
            if date > Date(){
                //Circle()
                //    .fill(.blue.opacity(0.2))
                // Will keep this in for now to check that the logic works
            }
            else{
                if notCompleted.contains(where: {$0 == date}){
                    Image(systemName: "multiply")
                        .resizable()
                        .foregroundColor(.red)
                }
                else{
                    Image(systemName: "checkmark")
                        .resizable()
                        .foregroundColor(.green)
                }
            }
        }
        else{
            Image(systemName: "multiply")
                .resizable()
                .foregroundColor(.blue)
        }
    }
}


struct Calendar_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        let testInitDate = Calendar.autoupdatingCurrent.nextDate(after: .now, matching: .init(day:1), matchingPolicy: .strict,direction: .backward)!

        Calendar_Card_View(delegate: CalendarDelegate(notCompleted: [], initDate: testInitDate, month: 04, year: 2023, routine: previewsRoutine))
    }
}

extension Routine{
    
}


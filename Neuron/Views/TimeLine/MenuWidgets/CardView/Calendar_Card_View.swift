//
//  Calendar_Card_View.swift
//  Neuron
//
//  Created by Alvin Wu on 2/9/23.
//

import SwiftUI
import AWCalendar

class CustomCalendar : CalendarController {
    
    @Published var completed : [Date]
    @Published var notCompleted : [Date] = []
    
    init(isHighlighted: [Date],notCompleted: [Date], month: Int,year: Int) {
        self.completed = isHighlighted
        super.init(monthOf: month, yearOf: year)
    }
    
    func isSameDay(date:Date)-> Bool{
       completed.contains(where: {Calendar.current.isDate($0, inSameDayAs: date)})
    }
    
    override func onTapEnd(_ day: dayComponent) {
        if isSameDay(date: day.value){
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
        let interval = DateInterval(start: delegate.selectedCal.firstday, end: delegate.selectedCal.lastDay)
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

        }
    }
    
    @ViewBuilder func highlightCirc(date:Date)->some View{
        if delegate.selectedCal.isSameDay(date: date){
            if date > Date(){
                Circle()
                    .fill(.blue.opacity(0.2))
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
            EmptyView()
        }
    }
}

struct Calendar_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        Calendar_Card_View(delegate: CalendarDelegate(notCompleted: [], initDate: Date(), month: 10, year: 2023, routine: previewsRoutine))
    }
}

extension Routine{
    
}


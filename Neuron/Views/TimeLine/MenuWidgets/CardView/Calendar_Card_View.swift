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
    @ObservedObject var cal : CustomCalendar
    let month : Int
    
    var notCompleted : [Date]{
        let interval = DateInterval(start: cal.firstday, end: cal.lastDay)
        return cal.notCompleted.filter({interval.contains($0)})
    }
    
    
    var titleMonth : String{
        let months = Calendar.current.monthSymbols
        return months[month-1]
    }
    
    init(cal : CustomCalendar,month : Int ){
        _cal = .init(wrappedValue: cal)
        self.month = month
    }
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text(titleMonth)
                    .font(.system(.headline,design: .monospaced,weight: .semibold))
            }
            HStack(spacing: 0){
                ForEach(daysofweek.indices,id:\.self){index in
                    Text(daysofweek[index])
                        .opacity(0.5)
                        .frame(width: 40)
                    
                }
            }
            AWCalendarView(cal: cal){ item in
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
        if cal.isSameDay(date: date){
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
        Calendar_Card_View(cal: CustomCalendar(isHighlighted: [], notCompleted: [], month: 2, year: 2023), month: 2)
    }
}

extension Routine{
    
}


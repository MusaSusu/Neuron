//
//  Menu_Routine_CompletetionView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/28/23.
//

import SwiftUI

struct Menu_Routine_CompletetionView: View {
    @ObservedObject var Item : Routine
    
    var schedData : [ (DateInterval,[Int],[Bool]) ]{
        Item.getDataForTimeLineMenu()
    }

    var body: some View {
        VStack(spacing:5){
            HStack{
                Spacer()
                Text("Completion Rate : " +
                    Item.completionRate.formatted(.percent.precision(.significantDigits(4)))
                )
            }
            HStack{
                //MARK: TODO: Make into tabview for more timings a week
                ForEach(schedData.indices, id:\.self){item in
                    let sched =  schedData[item]
                    let week = createWeekRange(date: sched.0.end)
                    
                    ForEach(daysofweek.indices, id:\.self){day in
                        
                        VStack{
                            Text(daysofweek[day].prefix(1))
                            Image(systemName: Date.now > week[day] ?  "circle.inset.filled" : "circle")
                                .opacity(sched.1.contains(where: {$0 == day}) ? 1 : 0)
                                .foregroundColor(sched.2[day] ? .green : .red)
                        }
                    }
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray).opacity(0.2) //white: 0.995
                .shadow(radius: 5)
        )
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
}

struct Menu_Routine_CompletetionView_Previews: PreviewProvider {
    static var previews: some View {
        Menu_Routine_CompletetionView(Item: previewsRoutine)
    }
}

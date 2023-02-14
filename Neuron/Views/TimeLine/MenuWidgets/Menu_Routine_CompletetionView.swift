//
//  Menu_Routine_CompletetionView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/28/23.
//

import SwiftUI

struct Menu_Routine_CompletetionView: View {
    @ObservedObject var Item : Routine
    
    var schedData : [ (DateInterval,[Int]) ]{
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
                ForEach(schedData.indices, id:\.self){index in
                    let sched =  schedData[index]
                    let week = createWeekRange(date: sched.0.end)
                    
                    ForEach(daysofweek.indices, id:\.self){dayIndex in

                        VStack{
                            Text(daysofweek[dayIndex].prefix(1))
                            Image(systemName: Date.now > week[dayIndex] ?  "circle.inset.filled" : "circle")
                                .opacity(sched.1[dayIndex] != 0 ? 1 : 0)
                                .foregroundColor(sched.1[dayIndex] == 2 ? .green : .red)
                        }
                    }
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.opacity(0.995)) //white: 0.995
                .shadow(radius: 5)
        )
    }
}

struct Menu_Routine_CompletetionView_Previews: PreviewProvider {
    static var previews: some View {
        Menu_Routine_CompletetionView(Item: previewsRoutine)
    }
}

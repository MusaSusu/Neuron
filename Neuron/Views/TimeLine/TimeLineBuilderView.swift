//
//  FullTimelineView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/3/22.
//

import SwiftUI

struct TimeLineBuilderView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var routineDates : FetchedResults<Routine_Schedule>
    @FetchRequest var dates: FetchedResults<DateEntity>
    
    let date : Date
    var dateofweek : Int {
        Int(date.weekdayAsInt())
    }
    
    var taskDates : [TaskDate]{
        return dates.first?.taskDates?.allObjects as? [TaskDate] ?? []
    } //update taskdates for multiple ents if needed later
    
    var routineItems: [(any timelineItems,DateInterval,taskType,Binding<Bool>)]{
        routineDates.compactMap({
            ($0.ofRoutine,
             $0.dateInterval(date: date),
             taskType.routine,
             $0.getBinding(date: dateofweek)
            )
            as? ( any timelineItems, DateInterval,taskType,Binding<Bool>)
        })
    }
    
    var taskItems : [(any timelineItems,DateInterval,taskType,Binding<Bool>)] {
        var array : [(any timelineItems,DateInterval,taskType,Binding<Bool>)] = []
        for item in taskDates{
            if let temp = item.task{
                temp.dateStart = item.date
                array.append(
                    (temp,
                     temp.dateInterval,
                     .task,
                     Binding<Bool>.init(get: {temp.taskChecker}, set: {newval in temp.taskChecker = newval})
                    )
                )
            }
        }
        return array as [(any timelineItems,DateInterval,taskType,Binding<Bool>)]
    }
    
    //wrap items into a value struct to allow for other types of classes to be displayed in future
    
    var combinedArray : [( TimelineItemWrapper, Binding<Bool> )] {
        let temp = routineItems + taskItems
        return temp.compactMap({ (TimelineItemWrapper($0.0, date: $0.1, type: $0.2),$0.3) } )
    }
    
    init(date: Date) {
        _dates = FetchRequest<DateEntity>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "dateGroup >= %@ AND dateGroup <= %@", date as CVarArg, date.endOfDay() as CVarArg )
        )
        _routineDates = fetchRoutinesByWeekday(date: date)
        self.date = date
    }
    
    
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: false){
                TimeLineListBuilderView(arrayobjects: combinedArray)
                    .padding(.top,10)
                    .padding(.horizontal,5)
                VStack{
                }.frame(height:300)
            }
        }
        .cornerRadius(10)
        .background(
            Color(white : 0.995)
                .cornerRadius(10)
                .shadow(radius: 5)
        )
    }
}

struct TimeLineBuilderView_Previews: PreviewProvider {
    static var previews: some View {
   TimeLineBuilderView( date: convertDate(data: "01-07-2023",format: "MM-dd-yyyy").startOfDay())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

func fetchRoutinesByWeekday(date:Date) -> FetchRequest<Routine_Schedule>{
    FetchRequest<Routine_Schedule>(
        sortDescriptors: [],
        predicate: NSPredicate(format:"SUBQUERY(daysofweek, $x, $x.weekday == %i).@count>0 ", date.weekdayAsInt())
    )
}


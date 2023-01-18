//
//  FullTimelineView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/3/22.
//

import SwiftUI
import CoreData

struct GenericTimeLineBuilderView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var routines : FetchedResults<Routine_Schedule>
    @FetchRequest var dates: FetchedResults<DateEntity>
    @State private var draggedSelection: Tasks?
    
    let date : Date
    
    var taskDates : [TaskDate]{
        return dates.first?.taskDates?.allObjects as? [TaskDate] ?? []
    }//update taskdates for multiple ents
        
    var routineDates: [(NSManagedObjectID,DateInterval,Int)]{routines.compactMap({ ($0.ofRoutine?.objectID,$0.dateInterval(date: date),1) as? (NSManagedObjectID, DateInterval,Int)})}
    
    var taskItems : [(NSManagedObjectID,DateInterval,Int)] {
        var array : [(NSManagedObjectID,DateInterval,Int)] = []
        for item in taskDates{
            if (item.task != nil){
                item.task!.dateStart = item.date
                let temp = item.task!
                array.append((temp.objectID,temp.dateInterval,0))
            }
        }
        return array
    }
    
    var sortedArray : [(NSManagedObjectID,DateInterval,Int)] {
        let temp = taskItems + routineDates
        return temp.sorted(by: {$0.1.start < $1.1.start})
    }
    
    var durationArray: [TimeInterval]{
        var array = [TimeInterval]()
        let temp = sortedArray
        let first = temp[0..<temp.endIndex].map{$0.1.end}
        let second = temp[1...].map{$0.1.start}
        for (endTime,startTime) in zip(first,second){
            array.append(startTime.timeIntervalSince(endTime))
        }
        array.append(-10)
        return array
    }
    
    init(date: Date) {
        _dates = FetchRequest<DateEntity>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "dateGroup >= %@ AND dateGroup <= %@", date as CVarArg, date.endOfDay() as CVarArg )
        )
        _routines = fetchRoutinesByWeekday(date: date)
        self.date = date
    }
    
    
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:0){
                    ForEach( Array(sortedArray.enumerated()) , id: \.element.0) { index,item in
                        checkType(item.2, item: viewContext.object(with: item.0), index: index, date: item.1)
                    }
                }.padding(.top,20)
                
                VStack{
                }.frame(height:300)
                
            }
        }
        .cornerRadius(20)
        .background(
            Color(white : 0.995)
                .cornerRadius(20)
                .shadow(radius: 5)
        )
    }
    @ViewBuilder
    func checkType(_ num : Int, item : NSManagedObject, index : Int,date:DateInterval) ->  some View{
        if num == 0{
            GenericTimelineRowView<Tasks>(task: item as! Tasks, nextDuration: durationArray[index]/2,date:date,widgetsArray: [.menu,.description] )
        }
        else{
            GenericTimelineRowView<Routine>(task: item as! Routine, nextDuration: durationArray[index]/2,date: date,widgetsArray: [.menu,.description])
        }
    }
}

struct GenericTimeLineBuilderView_Previews: PreviewProvider {
    static var previews: some View {
    GenericTimeLineBuilderView( date: convertDate(data: "12-21-2022",format: "MM-dd-yyyy").startOfDay())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

func fetchRoutinesByWeekday(date:Date) -> FetchRequest<Routine_Schedule>{
    FetchRequest<Routine_Schedule>(
        sortDescriptors: [],
        predicate: NSPredicate(format:"SUBQUERY(daysofweek, $x, $x.weekday == %i).@count>0 ", date.weekdayAsInt())
    )
}

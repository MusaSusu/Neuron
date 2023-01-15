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
    
    
    @FetchRequest var dates: FetchedResults<DateEntity>
    @State private var draggedSelection: Tasks?
    @FetchRequest<Routine>(sortDescriptors: []) var routineItems
    
    let date : Date
    
    var taskDates : [TaskDate]{
        return dates.first?.taskDates?.allObjects as? [TaskDate] ?? []
    }
    
    var routineDates : [(NSManagedObjectID,DateInterval,Int)] {
        var array : [(NSManagedObjectID,DateInterval,Int)] = []
        for item in Array(routineItems){
            array.append( (item.objectID, item.dateInterval,1))
        }
        return array
    }
    
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
        self.date = date
    }
    
    
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:0){
                    ForEach( Array(sortedArray.enumerated()) , id: \.element.0) { index,item in
                        checkType(item.2, item: viewContext.object(with: item.0), index: index)
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
    func checkType(_ num : Int, item : NSManagedObject, index : Int) ->  some View{
        if num == 0{
            GenericTimelineRowView<Tasks>(task: item as! Tasks, nextDuration: durationArray[index]/2)
        }
        else{
            GenericTimelineRowView<Routine>(task: item as! Routine, nextDuration: durationArray[index]/2)
        }
    }
}

struct GenericTimeLineBuilderView_Previews: PreviewProvider {
    static var previews: some View {
    GenericTimeLineBuilderView( date: convertDate(data: "12-21-2022",format: "MM-dd-yyyy").startOfDay())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

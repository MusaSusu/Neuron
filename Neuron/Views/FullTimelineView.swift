//
//  FullTimelineView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/3/22.
//

import SwiftUI

let testingDate = "10-16-2022"

struct FullTimelineView: View {
    
    
    @FetchRequest var items: FetchedResults<Tasks>

    var uuid: UUID = (UUID())
    
    init(date: String) {
        _items = FetchRequest<Tasks>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.dateStart, ascending: true)],
            predicate: NSPredicate(format: "taskByDate.dateString = %@", date )
        )
    }

    var durationArray: [TimeInterval]{
        var array = [TimeInterval]()
        let temp = Array(items)
        let first = temp[0..<items.endIndex].map{$0.dateEnd!}
        let second = temp[1...].map{$0.dateStart!}
        for (endTime,startTime) in zip(first,second){
            array.append(startTime.timeIntervalSince(endTime))
        }
        array.append(-10)
        return array
    }

    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            //MARK: TODO: Add a function that takes an array of the tasks for the day,so I have the start and end times of every task, so then I can divide the entire day up while using taskview to create the entire view
            VStack(spacing:0){
                ForEach( Array(items.enumerated()) , id: \.element) { index,item in
                    TimelineRowView(task: item,prevDuration: index == 0 ? -5 : durationArray[index-1]/2, nextDuration: durationArray[index]/2).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                }
            }
            
            
            VStack{
                
            }.frame(height:300)
            
        }.cornerRadius(25)
            .background(
                Color(white : 0.995)
                    .cornerRadius(25)
                    .shadow(radius: 5)
            )
    }
}


private func extractDate(date: Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy HH:mm"
    return formatter.string(from:date)
}


struct FullTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        FullTimelineView( date:"10-16-2022")
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DataSource())
    }
}

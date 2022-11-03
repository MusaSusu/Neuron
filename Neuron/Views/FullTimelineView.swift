//
//  FullTimelineView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/3/22.
//

import SwiftUI

struct FullTimelineView: View {
    
    
    @FetchRequest var items: FetchedResults<Tasks>
    
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
            
            VStack(spacing:0){
                ForEach( Array(items.enumerated()) , id: \.element) { index,item in
                    TimelineRowView(task: item,prevDuration: index == 0 ? -5 : durationArray[index-1]/2, nextDuration: durationArray[index]/2).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                }
            }
            
            VStack{
            }.frame(height:300)
            
        }.cornerRadius(20)
            .background(
                Color(white : 0.995)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            )
    }
}

struct FullTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        FullTimelineView( date:"10-27-2022")
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

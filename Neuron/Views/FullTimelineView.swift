//
//  FullTimelineView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/3/22.
//

import SwiftUI

struct FullTimelineView: View {
    
    @FetchRequest var items: FetchedResults<Tasks>
    
    @State private var draggedSelection: Task?
    
    var datesList : [DateInterval] {
        var temp : [DateInterval] = []
        for item in Array(items){
            temp.append(item.date)
        }
        return temp
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
    
    init(date: String) {
        _items = FetchRequest<Tasks>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.dateStart, ascending: true)],
            predicate: NSPredicate(format: "taskDay == %@", date )
        )
    }
    

    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:0){
                    ForEach( Array(items.enumerated()) , id: \.element) { index,item in
                        testTimelineRowView(task: item, nextDuration: durationArray[index]/2)
                            .onDrag {
                                return NSItemProvider()
                            } preview: {
                                VStack{
                                    Circle()
                                        .frame(width: 45,height: 45)
                                        .mask{
                                            Image(systemName: item.icon!)
                                                .frame(width: 45,height:45)
                                        }
                                }
                                .frame(width: 45,height: 45)
                                .contentShape(.dragPreview, Circle())
                            }
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
}

struct FullTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        FullTimelineView( date:"12-21-2022")
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

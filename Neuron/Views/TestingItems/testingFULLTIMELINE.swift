//
//  FullTimelineView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/3/22.
//

import SwiftUI

struct testFullTimelineView: View {
        
    @FetchRequest var items: FetchedResults<Tasks>
    let selectedDate : Date

    
    init(date: String) {
        let req = FetchRequest<Tasks>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.dateStart, ascending: true)],
            predicate: NSPredicate(format: "taskDay == %@", date )
        )
        _items = req
        selectedDate = convertDate(data:date + " 00:00")
    }
    
    var timelineItems : [TimeLineItemModel] {
        var temparray : [TimeLineItemModel] = []
        for item in Set(items){
            let temp = TimeLineItemModel(icon: item.icon ?? "", start: (item.dateStart!.timeIntervalSince(selectedDate) / 60) , duration: item.duration, color: item.color?.fromDouble() ?? .red)
            temparray.append(temp)
        }
        return temparray
        
    }
    
    
    let testingarray:[Int] = .init(repeating: 1, count: 16)
    let date = Date.now - 60000
    let duration:TimeInterval = 24 * 60
    let color : Color = .red
    
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: false){
            
            VStack(spacing:0){
                ZStack{
                    HStack{
                        VStack{
                            TimelineView(.periodic(from: date, by: 30)){context in
                                let value = max(context.date.timeIntervalSince(date) / duration, 0)
                                let gradient = Gradient(stops: [
                                    .init(color: color, location: 0),
                                    .init(color: Color(white: 0.95), location: value),
                                ])
                                drawTopDashes()
                                    .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                            }
                        }.frame(width:15,height: 60 * 1.5 * 16)
                        VStack{
                            TimeLinesomething(items: timelineItems)
                        }
                    }.frame(height: 60 * 1.5 * 16)
                }
            }.frame(width: 500)
            
            VStack{
            }.frame(height:300)
            
        }.cornerRadius(20)
            .background(
                Color(white : 0.995)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            )
    }
    private struct drawTopDashes: Shape {
        func path(in rect: CGRect) -> Path {
            let path = Capsule().path(in: rect)
            return path
        }
    }
}

struct testFullTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        testFullTimelineView( date:"12-14-2022")
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

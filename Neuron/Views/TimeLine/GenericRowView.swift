
//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/4/22.
//

import SwiftUI
import CoreData

//MARK: Use a function to calculate length of the task in order to set the frame height.


struct GenericTimelineRowView<T : NSManagedObject & isTimelineItem> : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var selectionMenu : MenuWidgets = .menu
    @ObservedObject var task : T
    @Binding var taskChecker : Bool
    
    
    let dateStart : Date
    let dateEnd : Date
    let nextDuration: TimeInterval
    let setColor: Color
    let capsuleHeight: CGFloat
    let widgetsArray : [MenuWidgets]
    
    
    var formattedStartDate: String { dateStart.formatted(date: .omitted, time: .shortened)}
    var formattedEndDate: String {dateEnd.formatted(date: .omitted, time: .shortened)}
    
    init(task: T,nextDuration: TimeInterval,date:DateInterval,widgetsArray:[MenuWidgets],taskCheck : Binding<Bool>){
        self.capsuleHeight = {
            let duration = abs((CGFloat(task.duration) / 1800))
            if duration <= 1 {
                return 90
            }
            else if duration >= 6 {
                return 480
            }
            else {
                return duration * 80
            }
        }()
        self.dateStart = date.start
        self.dateEnd = date.end
        self.setColor = task.color!.fromDouble()
        self.nextDuration = {
            if nextDuration < 1 {
                return 5
            }
            else if nextDuration / 3600 < 0.5 {
                return 25
            }
            else if nextDuration / 3600 < 1{
                return 50
            }
            return 75
        }()
        self.task = task
        self.widgetsArray = widgetsArray
        _taskChecker = taskCheck
    }
    
    var body: some View {
        
        HStack(spacing:0){
            
            HStack(alignment:.center,spacing: 0){
                VStack(alignment:.trailing,spacing:0){
                    Text(formattedStartDate)
                        .timeFont()
                        .lineLimit(1)
                        .offset(y:-2.5)
                    Spacer()
                    Text(formattedEndDate)
                        .timeFont()
                        .offset(y:2.5)
                        .lineLimit(1)
                }.frame(width:60,height: capsuleHeight,alignment: .trailing)
                
                ZStack{
                    VStack(spacing: 0){
                        setTimeLineGradient(color: setColor, date: dateStart, duration: nextDuration, height: capsuleHeight)
                    }.frame(width:15,height: capsuleHeight)
                    VStack{
                        Spacer()
                        drawCapsule(date: dateStart, duration: task.duration )
                            .onTapGesture {
                                if selectionMenu == .menu{
                                    selectionMenu = .none
                                }
                                else{
                                    selectionMenu = .menu
                                }
                            }
                        Spacer()
                    }
                }
                .offset(x:-15)
                
            }.frame(width:80)
            
            SelectionMenuBuilderView(task: task, selectionMenu: $selectionMenu,taskChecker: $taskChecker, capsuleHeight: capsuleHeight, initState: taskChecker)
            
            Spacer()
        }
        .frame(height: capsuleHeight)
        .padding(.leading,10)
        
        HStack(spacing: 0){
            
        }.frame(height: nextDuration)
    }
    
    func drawCapsule(date:Date,duration:TimeInterval) -> some View{
        TimelineView(.periodic(from: date, by: 30)){context in
            let value = max(0,context.date.timeIntervalSince(date) / duration)
            let gradient = Gradient(stops: [
                .init(color: setColor, location: 0),
                .init(color: Color(white: 0.95), location: value),
            ])
            ZStack{
                Capsule()
                    .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 1.25) ) )
                    .frame(width: 45, height: 45)
                let gradient = Gradient(stops: [
                    .init(color: .white, location: 0),
                    .init(color: setColor, location: value),
                ])
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 2))
                    .mask(Image(systemName:task.icon ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    ).frame(width: 30.0, height: 30.0)
            }
        }
    }
}

private struct setTimeLineGradient: View{
    let color: Color
    let date: Date
    let duration: TimeInterval
    let height: CGFloat
    
    var body: some View {
        TimelineView(.periodic(from: date, by: 30)){ context in
            let value = max(context.date.timeIntervalSince(date) / duration, 0)
            let gradient = Gradient(stops: [
                .init(color: color, location: 0),
                .init(color: Color(white: 0.95), location: value),
            ])
            ZStack{
                drawDashes()
                    .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                if duration != 0{
                    drawIntervalDashes(duration: duration)
                        .fill(.gray)
                }
            }
        }
    }
    private struct drawDashes: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: (rect.midX), y: (rect.minY)  ))
            path.addLine(to: CGPoint(x: (rect.midX), y: (rect.maxY)  ))
            path = path.strokedPath(.init(lineWidth: 5 ,lineCap:.round,miterLimit: 0, dash: [0]))
            return path
        }
    }
    private struct drawIntervalDashes: Shape{
        let duration : CGFloat
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.midX, y: (rect.maxY + 5)  ))
            path.addLine(to: CGPoint(x: (rect.midX), y: rect.maxY + (duration - 5) ))
            path = path.strokedPath(.init(lineWidth: 4,lineCap: .round,dash:  [6],dashPhase:1))
            return path
        }
    }
}

private extension View{
    func timeFont() -> some View{
        self
            .font(.system(size:14).weight(.light))
    }
}


struct GenericTimelineRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        GenericTimelineRowView<Tasks>(task: previewscontainer,nextDuration: 1200,date: previewscontainer.dateInterval,widgetsArray: [.menu,.description], taskCheck : .constant(true)
        )
        
        .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}



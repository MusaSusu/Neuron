
//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/4/22.
//

import SwiftUI

//MARK: Use a function to calculate length of the task in order to set the frame height.


struct CapsuleRowView : View {
        
    @Binding var selectionMenu : MenuWidgets
        
    let task : timelineItemWrapper
    let dateStart : Date
    let dateEnd : Date
    let nextDurationHeight: TimeInterval
    var setColor: Color{task.color}
    let widgetsArray : [MenuWidgets]
    let capsuleHeight: CGFloat
    
    
    var formattedStartDate: String { dateStart.formatted(date: .omitted, time: .shortened)}
    var formattedEndDate: String {dateEnd.formatted(date: .omitted, time: .shortened)}
    
    init(task: timelineItemWrapper,nextDuration: TimeInterval,date:DateInterval,widgetsArray:[MenuWidgets],capsuleHeight:CGFloat,selectionMenu: Binding<MenuWidgets>){
        self.dateStart = date.start
        self.dateEnd = date.end
        self.nextDurationHeight = nextDuration
        self.task = task
        self.widgetsArray = widgetsArray
        self.capsuleHeight = capsuleHeight
        _selectionMenu = selectionMenu
    }
    
    var body: some View {
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
            }.frame(width:70,height: capsuleHeight,alignment: .trailing)
            
                VStack{
                    Spacer()
                    drawCapsule(date: dateStart, duration: nextDurationHeight)
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
                .offset(x:-15)
        }
        .frame(width:80, height:capsuleHeight)
        .padding(.horizontal,5)
    }
    
    func drawCapsule(date:Date,duration:TimeInterval) -> some View{
        TimelineView(.periodic(from: date, by: 30)){context in
            let value = max(0,context.date.timeIntervalSince(date) / duration)
            let gradient = Gradient(stops: [
                .init(color: setColor, location: 0),
                .init(color: Color(white: 0.95), location: value),
            ])
            ZStack{
                
                VStack(spacing: 0){
                    ZStack{
                        drawDashes()
                            .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        if duration != 0{
                            drawIntervalDashes(duration: duration)
                                .fill(.gray)
                        }
                    }
                }.frame(height: capsuleHeight)
                
                Capsule()
                    .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 1.25) ) )
                    .frame(width: 45, height: 45)
                let gradient = Gradient(stops: [
                    .init(color: .white, location: 0),
                    .init(color: setColor, location: value),
                ])
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 2))
                    .mask(Image(systemName:task.icon )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    ).frame(width: 30.0, height: 30.0)
                
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

private extension View{
    func timeFont() -> some View{
        self
            .font(.system(size:14).weight(.light))
    }
}


struct GenericTimelineRowView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleRowView(task: .init(previewscontainer,date:previewscontainer.dateInterval, type: .task),nextDuration: 50,date: previewscontainer.dateInterval,widgetsArray: [.menu,.description], capsuleHeight: 100, selectionMenu: .constant(.menu))
        .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}



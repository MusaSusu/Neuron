//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/4/22.
//

import SwiftUI


//MARK: Use a function to calculate length of the task in order to set the frame height.


struct TimelineRowView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var selectionMenu : MainWidgets = .none
    
    @ObservedObject var task: Tasks
    let id: UUID
    let icon: String
    let duration: CGFloat
    let taskTitle: String
    let text: String
    let dateStart : Date
    let dateEnd : Date
    let prevDuration: TimeInterval
    let nextDuration: TimeInterval
    
    let setColor: Color
    var capsuleHeight: CGFloat{
        let duration = abs((duration * 2))
        if duration <= 1 {
            return 45
        }
        else if duration >= 6 {
            return 240
        }
        else {
            return duration * 40.0
        }
    }
    
    var formattedStartDate: String { formatDate(data:dateStart)}
    var formattedEndDate: String {formatDate(data: dateEnd)}
    
    init(task: Tasks,prevDuration: TimeInterval,nextDuration: TimeInterval){
        self.task = task
        self.id = task.id!
        self.icon = task.icon!
        self.duration = CGFloat(task.duration) 
        self.taskTitle = task.title!
        self.dateStart = task.dateStart!
        self.dateEnd = task.dateEnd!
        self.setColor = task.color!.fromDouble()
        self.text = task.taskInfo!
        self.prevDuration = prevDuration
        self.nextDuration = nextDuration
    }
    
    var body: some View {
        
        HStack(spacing:0){
            
            HStack(spacing:0){
                Spacer()
                
                VStack{
                    Text(formattedStartDate)
                        .timeFont()
                    Spacer()
                    Text(formattedEndDate)
                        .timeFont()
                }.frame(width:65,height: capsuleHeight+20,alignment: .topLeading)
                
                Spacer()
                
                let startDate = dateStart.addingTimeInterval(-prevDuration)
                let endDate = dateEnd
                
                VStack(spacing: 0){
                    VStack{
                        if prevDuration != -5 {
                            setTimeLineGradient(color: setColor, date: startDate, duration: prevDuration, height: capsuleHeight, condition:"top")
                        }
                    }.frame(height:45)
                    VStack{
                        drawCapsule(date: dateStart, duration: duration * 3600)
                            .onTapGesture {
                                if selectionMenu == .menu{
                                    selectionMenu = .none
                                }
                                else{
                                    selectionMenu = .menu
                                }
                                
                            }
                    }.coordinateSpace(name: "Capsule")
                    
                    VStack{
                        if nextDuration != -5{
                            setTimeLineGradient(color: setColor, date: endDate, duration: nextDuration, height: capsuleHeight, condition: "bot")
                        }
                    }.frame(height: 45)
                    
                }.frame(height: capsuleHeight+100)
                
                Spacer()
                
            }.frame(width: 120).padding(5)
            
            VStack{
                switch selectionMenu {
                case .description:
                    TaskDescriptionView(task: task,capsuleHeight: capsuleHeight + 60.0)
                        .transition(.scale)
                case .menu:
                    TimeLineMenu(selectedMenu: $selectionMenu)
                        .transition(.scale(scale: 0,anchor: UnitPoint(x: 0 , y: 0.5)))
                case .none:
                    EmptyView()
                }
            }
            .animation(.easeInOut(duration: 0.2), value: selectionMenu)
            Spacer()
            
        }.frame(height:capsuleHeight+90)
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
                    .frame(width: 45.0, height: capsuleHeight)
                let gradient = Gradient(stops: [
                    .init(color: .white, location: 0),
                    .init(color: setColor, location: value),
                ])
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 2))
                    .mask(Image(systemName:icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    ).frame(width: 30.0, height: 30.0)
            }
        }
    }
}



private func formatDate(data: Date) -> String{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = "MM-dd-yyyy HH:mm"
    formatter4.timeStyle = .short
    return formatter4.string(from:data)
}

private struct setTimeLineGradient: View{
    let color: Color
    let date: Date
    let duration: TimeInterval
    let height: CGFloat
    let condition: String
    
    var body: some View {
        TimelineView(.periodic(from: date, by: 30)){context in
            let value = max(context.date.timeIntervalSince(date) / duration, 0)
            let gradient = Gradient(stops: [
                .init(color: color, location: 0),
                .init(color: Color(white: 0.95), location: value),
            ])
            Group{
                switch condition {
                case "top":
                    VStack{
                        drawTopDashes()
                            .stroke(style: StrokeStyle(lineWidth: 5))
                            .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                    }.frame(height: 45)
                case "bot":
                    VStack{
                        drawBotDashes()
                                .stroke(style: StrokeStyle(lineWidth: 5))
                                .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                    }.frame(height: 45)
                default:
                    Text("Default")
                }
            }
        }
    }
    
    private struct drawBotDashes: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: (rect.midX), y: (rect.minY)  ))
            path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY+10) ))
            
            
            path.move(to: CGPoint(x: (rect.midX), y: (rect.minY+20)  ))
            path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY+30) ))
            
            path.move(to: CGPoint(x: (rect.midX), y: (rect.minY+40) ))
            path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY+45) ))
            
            return path
        }
    }
    
    
    private struct drawTopDashes: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: (rect.midX), y: (rect.minY)  ))
            path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY+5) ))
            
            path.move(to: CGPoint(x: (rect.midX), y: (rect.minY+15)  ))
            path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY+25) ))
            
            path.move(to: CGPoint(x: (rect.midX), y: (rect.minY+35)  ))
            path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY+45) ))
            
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


struct TimelineRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        TimelineRowView(task: previewscontainer,prevDuration: 1200,nextDuration: 1200)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}



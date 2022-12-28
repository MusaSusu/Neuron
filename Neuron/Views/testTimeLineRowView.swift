

//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/4/22.
//

import SwiftUI


//MARK: Use a function to calculate length of the task in order to set the frame height.


struct testTimelineRowView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var selectionMenu : MainWidgets = .menu
    
    @ObservedObject var task: Time
    
    let id: UUID
    let icon: String
    let duration: CGFloat
    let taskTitle: String
    let text: String
    let dateStart : Date
    let dateEnd : Date
    let nextDuration: TimeInterval
    
    let setColor: Color
    
    var capsuleHeight: CGFloat{
        let duration = abs((duration / 1800))
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
    
    init(task: Time,nextDuration: TimeInterval){
        self.task = task
        self.id = task.id!
        self.icon = task.icon!
        self.duration = CGFloat(task.duration)
        self.taskTitle = task.title!
        self.dateStart = task.startTime!
        self.dateEnd = task.date.end
        self.setColor = task.color!.fromDouble()
        self.text = task.notes!
        self.nextDuration = {
            if nextDuration < 1 {
                return 0
            }
            else if nextDuration / 3600 < 0.5 {
                return 25
            }
            else if nextDuration / 3600 < 1{
                return 50
            }
            return 75
        }()
    }
    
    var body: some View {
        
        HStack(spacing:0){
            
            HStack(alignment:.center,spacing: 0){
                VStack(alignment:.trailing,spacing:0){
                    Text(formattedStartDate)
                        .timeFont()
                        .offset(y:-2.5)
                    Spacer()
                    Text(formattedEndDate)
                        .timeFont()
                        .offset(y:2.5)
                }.frame(width:60,height: capsuleHeight*2,alignment: .trailing)

                
                ZStack{
                    VStack(spacing: 0){
                        setTimeLineGradient(color: setColor, date: dateStart, duration: nextDuration, height: capsuleHeight)
                    }.frame(width:15,height: capsuleHeight*2)
                    VStack{
                        Spacer()
                        drawCapsule(date: dateStart, duration: duration )
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
            
            VStack{
                Spacer()
                switch selectionMenu {
                case .description:
                    TaskDescriptionView(task: task,capsuleHeight: capsuleHeight * 1.75 )
                        .transition(.scale)
                case .none:
                        TimeLineTitleView(task: task)
                case .menu:
                    TimeLineTitleView(task: task)
                    TimeLineMenu(selectedMenu: $selectionMenu)
                        .transition(.scale(scale: 0,anchor: UnitPoint(x: 0 , y: 0.5)))
                    
                }
                Spacer()
            }
            .animation(.easeInOut(duration: 0.2), value: selectionMenu)
            .padding(.leading,5)
            
            Spacer()
        }
        .frame(height: (capsuleHeight*2))
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
    
    var body: some View {
        TimelineView(.periodic(from: date, by: 30)){context in
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


struct testTimelineRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        testTimelineRowView(task: previewscontainer,nextDuration: 1200)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}



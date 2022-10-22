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
    
    @ObservedObject var task: Tasks
    let id: UUID
    let icon: String
    let duration: CGFloat
    let taskTitle: String
    let text: String
    let dateStart : Date
    let dateEnd : Date
    let setColor1: [Double]
    let prevDuration: TimeInterval
    let nextDuration: TimeInterval
    
    var setColor: Color {Color(red: setColor1[0], green: setColor1[1], blue: setColor1[2])}
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
        self.setColor1 = task.color!
        self.text = task.info!
        self.prevDuration = prevDuration
        self.nextDuration = nextDuration
    }
    
    var body: some View {
        
        HStack(spacing:0){
            
            HStack(spacing:0){
                
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
                        let tempDate = dateStart
                        let tempDuration = (duration * 3600)
                        createCapsule(color: setColor, date: tempDate, duration: tempDuration, height: capsuleHeight,icon:icon)
                        
                    }
                    VStack{
                        if nextDuration != -5{
                            setTimeLineGradient(color: setColor, date: endDate, duration: nextDuration, height: capsuleHeight, condition: "bot")
                        }
                    }.frame(height: 45)
                    
                }.frame(height: capsuleHeight+100)
                
                Spacer()
                
            }.frame(width: 120).padding(5)
            
            HStack(spacing: 0){
                VStack(alignment: .leading,spacing: 0){
                    TaskDescriptionView(taskTitle: taskTitle, duration: duration,setColor: setColor)
                    Text("\(id)")
                }
                
                    Spacer()
            }
            .frame(height: (capsuleHeight + 60.0), alignment: .topLeading)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(setColor).opacity(0.2) //white: 0.995
                    .shadow(radius: 5)
            )
            
            Spacer()
            
        }.frame(height:capsuleHeight+90)
    }
}


func formatDate(data: Date) -> String{
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
            ContainerView{
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
    
    private struct ContainerView<Content: View>: View {
        @ViewBuilder var content: Content
        
        var body: some View {
            VStack{
                content
            }
        }
    }
}

private struct createCapsule: View {
    let color: Color
    let date: Date
    let duration: TimeInterval
    let height: CGFloat
    let icon: String
    
    var body: some View{
        VStack{
            TimelineView(.periodic(from: date, by: 30)){context in
                let value = max(0,context.date.timeIntervalSince(date) / duration)
                let gradient = Gradient(stops: [
                    .init(color: color, location: 0),
                    .init(color: Color(white: 0.95), location: value),
                ])
                ZStack{
                    Capsule()
                        .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 1.25) ) )
                        .frame(width: 45.0, height: height)
                    let gradient = Gradient(stops: [
                        .init(color: .white, location: 0),
                        .init(color: color, location: value),
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
}




private extension View{
    func timeFont() -> some View{
        self
            .font(.system(size:14))
            .fontWeight(.light)
    }
}


struct TimelineRowView_Previews: PreviewProvider {

    static var previewscontainer: Tasks{
        let newItem = Tasks(context: PersistenceController.preview.container.viewContext)
        newItem.id = UUID()
        newItem.title = "Wake up"
        newItem.dateStart = convertDate(data: "10-17-2022 01:00")
        newItem.dateEnd = convertDate(data: "10-17-2022 01:30")
        newItem.info = "Wakey time 10-08"
        newItem.icon = "sun.max.fill"
        newItem.duration = 0.5
        newItem.color = [0.949,  0.522,  0.1]
        newItem.completed = false
        return newItem
    }
    
    static var previews: some View {
        TimelineRowView(task: previewscontainer,prevDuration: 1200,nextDuration: 1200).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



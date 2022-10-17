//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/4/22.
//

import SwiftUI


//MARK: Use a function to calculate length of the task in order to set the frame height.


struct TimelineRowView: View {

    let id: String
    let icon: String
    let duration: CGFloat
    let taskTitle: String
    let text: String
    let dateStart : String
    let dateEnd : String
    let setColor:Color
    let prevDuration: TimeInterval
    let nextDuration: TimeInterval
    
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
                
                let startDate = convertDate(data: dateStart).addingTimeInterval(-prevDuration)
                let endDate = convertDate(data: dateEnd)
                
                VStack(spacing: 0){
                    VStack{
                        if prevDuration != -5 {
                            setTimeLineGradient(color: setColor, date: startDate, duration: prevDuration, height: capsuleHeight, condition:"top")
                        }
                    }.frame(height:45)
                    VStack{
                        let tempDate = convertDate(data: dateStart)
                        let tempDuration = (duration * 3600)
                        createCapsule(color: setColor, date: tempDate, duration: tempDuration, height: capsuleHeight,       icon:icon)
                        
                    }
                    VStack{
                        if nextDuration != -5{
                            setTimeLineGradient(color: setColor, date: endDate, duration: nextDuration, height: capsuleHeight, condition: "bot")
                        }
                    }.frame(height: 45)
                    
                }.frame(height: capsuleHeight+90)
                
                Spacer()
                
            }.frame(width: 120).padding(5)
            
            HStack(spacing: 0){
                VStack(alignment: .leading,spacing: 0){
                    TaskDescriptionView(taskid: id,taskTitle: taskTitle, duration: duration,setColor: setColor)
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


func formatDate(data: String) -> String{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = "MM-dd-yyyy HH:mm"
    let returnstring = formatter4.date(from: data)
    formatter4.timeStyle = .short
    return formatter4.string(from:returnstring ?? Date.now)
}

private func convertDate(data: String) -> Date{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = "MM-dd-yyyy HH:mm"
    return formatter4.date(from: data) ?? Date.now
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
            path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY+50) ))
            
            
            return path
        }
    }
    
    
    private struct drawTopDashes: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: (rect.midX), y: (rect.minY-5)  ))
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
    static var previews: some View {
        TimelineRowView(id: "1", icon: "moon.fill",duration:0.5,taskTitle:"Bedtime", text:"fdsafdsfadsfsadf",dateStart:"10-16-2022 01:45", dateEnd: "10-16-2022 02:15",setColor: .orange,prevDuration: 1200,nextDuration: 1200).environmentObject(DataSource())
    }
}

//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/4/22.
//

import SwiftUI


//MARK: Use a function to calculate length of the task in order to set the frame height.


struct TimelineRowView: View {

    let icon: String
    let duration: CGFloat
    let text: String
    let dateStart : String
    let dateEnd : String
    let setColor:Color
    

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
    
    var body: some View {
        
        HStack(spacing:0){
            
            HStack(spacing:0){
                
                VStack{
                    Text(extractDate(data:dateStart))
                        .timeFont()
                    Spacer()
                    Text(extractDate(data:dateEnd))
                        .timeFont()
                }.frame(width:65,height: capsuleHeight+20,alignment: .topLeading)
                
                Spacer()
                VStack{
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20.0, height: 20.0)
                        .foregroundColor(.white)
                        .background{
                            ZStack{
                                Capsule()
                                    .fill(setColor)
                                    .frame(width: 45.0, height: capsuleHeight)
                                drawDashes()
                                    .stroke(style: StrokeStyle(lineWidth: 5))
                                    .fill(setColor)
                            }
                        }
                }
                Spacer()
                
            }.frame(width: 120).padding(5)
            
            HStack{
                Text(text)
                Spacer()
            }
            .frame(height: (capsuleHeight + 60.0), alignment: .leading)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(setColor).opacity(0.3) //white: 0.995
                    .shadow(radius: 5)
            )
            
            Spacer()
            
        }
        .frame(height:capsuleHeight+90)
    }
}


private func extractDate(data: String) -> String{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = "MM-dd-yyyy HH:mm"
    let returnstring = formatter4.date(from: data)
    formatter4.timeStyle = .short
    return formatter4.string(from:returnstring ?? Date.now)
}

private extension View{
    func timeFont() -> some View{
        self
            .font(.system(size:14))
            .fontWeight(.light)
    }
}

private struct drawDashes: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
            
        path.move(to: CGPoint(x: (rect.midX), y: (rect.minY)  ))
        path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY-10) ))
        path.move(to: CGPoint(x: (rect.midX), y: (rect.maxY)  ))
        path.addLine(to: CGPoint(x:(rect.midX), y: (rect.maxY+10) ))
        
        path.move(to: CGPoint(x: (rect.midX), y: (rect.minY-20)  ))
        path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY-30) ))
        path.move(to: CGPoint(x: (rect.midX), y: (rect.maxY+20)  ))
        path.addLine(to: CGPoint(x:(rect.midX), y: (rect.maxY+30) ))
        
        path.move(to: CGPoint(x: (rect.midX), y: (rect.minY-40)  ))
        path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY-45) ))
        path.move(to: CGPoint(x: (rect.midX), y: (rect.maxY+40) ))
        path.addLine(to: CGPoint(x:(rect.midX), y: (rect.maxY+45) ))
        
            
        return path
    }
}
private struct drawDashes2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: (rect.midX), y: (rect.minY-45)  ))
        path.addLine(to: CGPoint(x:(rect.midX), y: (rect.minY-50) ))
        path.move(to: CGPoint(x: (rect.midX), y: (rect.maxY+45) ))
        path.addLine(to: CGPoint(x:(rect.midX), y: (rect.maxY+50) ))
        
        return path
    }
}


struct TimelineRowView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineRowView(icon: "moon.fill",duration:0.5,text:"fdsafdsfadsfsadf",dateStart:"10-05-2022 12:20", dateEnd: "10-05-2022 12:20",setColor: .pink)
    }
}

//
//  TaskCardSheetView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/31/23.
//

import SwiftUI

struct TaskCardSheetView<T: isTimelineItem>: View {
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
    
    @ObservedObject var Item : T
    let width : CGFloat

    var body: some View {
        VStack(spacing:10){
            TitleView()
            
            HStack(spacing: 10){
                Spacer()
                IconView(color: .white, backgroundColor: Item.getColor(), icon: Item.icon!, dims: .init(width: 20, height: 20) )
                    .frame(width: 30,height: 30)
                Spacer()
            }
            
            HStack{
                Text("Duration")
                    .padding(10)
                Spacer()
                Text(Item.duration.toHourMin(from: .seconds))
                    .padding(10)
            }.backgroundStrokeBorder(opacity: 1, lineWidth: 0)
                        
            HStack{
                Task_Dates_CardSheet(Task: Item as! Tasks)
            }
            
            HStack{
                
            }

        }
        .frame(width: width * 0.75,alignment: .leading)
        .padding(20)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 0.9), strokeBorder: userColor,lineWidth: 2)
        }
        .edgesIgnoringSafeArea(.bottom)

    }
    
    
    
    @ViewBuilder
    func TitleView() -> some View{
        HStack{
            ZStack{
                IconView(color: Item.getColor(), icon: Item.icon!, dims: .init(width: 25, height: 25))
            }
            .frame(width: 40).padding(.leading,10)
            
            Spacer()
            Text(Item.title!).titleFont().offset(x:-20)
            Spacer()
        }   
        .background{
                RoundedRectangle(cornerRadius: 25,style: .continuous)
                    .fill(Color(white:0.99))
                    .frame(height: 60)
        }.frame(height: 80)
    }
}

struct TaskCardSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardSheetView<Tasks>(Item: previewsTasks,width: 400)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}


struct StrokeBackgroundBorder : ViewModifier{
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
    let opacity : CGFloat
    let lineWidth : CGFloat
    
    func body(content: Content) -> some View {
        content
            .background{
                RoundedRectangle(cornerRadius: 10,style: .circular)
                    .fill(Color(white: opacity), strokeBorder: userColor,lineWidth: lineWidth)
            }
    }
}

struct IconView : View {
    let color : Color
    var backgroundColor : Color = .white
    let icon : String
    let dims : CGSize
    
    var body: some View{
        ZStack{
            Circle()
                .fill(color)
            Rectangle()
                .fill(backgroundColor)
                .mask{
                    Image(systemName:icon)
                        .resizeFrame(width: dims.width, height: dims.height)
                }
        }
    }
}

extension View{
    func backgroundStrokeBorder(opacity: CGFloat, lineWidth: CGFloat)-> some View{
        modifier(StrokeBackgroundBorder(opacity: opacity, lineWidth: lineWidth))
    }

}

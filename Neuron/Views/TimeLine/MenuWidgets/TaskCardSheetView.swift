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
    
    @ObservedObject var Task : T
    let width : CGFloat

    var body: some View {
        VStack{
            TitleView()
            
        }.padding(10)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 0.9), strokeBorder: userColor,lineWidth: 2)
                .padding(.horizontal,20)
                .frame(width: width)
        }
        .edgesIgnoringSafeArea(.bottom)

    }
    
    @ViewBuilder
    func TitleView() -> some View{
        HStack{
            ZStack{
                Circle()
                    .fill(Task.getColor())
                Rectangle()
                    .fill(.white)
                    .mask{
                        Image(systemName:Task.icon!)
                            .resizeFrame(width: 25, height: 25)
                    }
            }
            .frame(width: 40).padding(.leading,10)
            
            Spacer()
            Text(Task.title!).titleFont().offset(x:-20)
            Spacer()
        }
        .frame(minWidth: width/2,maxWidth: width * 0.75,alignment: .leading)
        .background{
            ZStack{
                RoundedRectangle(cornerRadius: 25,style: .continuous)
                    .fill(Color(white:0.99))
            }.frame(height: 60)
        }.frame(height: 80)
    }
}

struct TaskCardSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardSheetView<Tasks>(Task: previewsTasks,width: 400)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

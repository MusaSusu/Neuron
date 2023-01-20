//
//  Header_ScrollTabView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/9/23.
//

import SwiftUI

struct Header_ScrollTabView: View {
    @EnvironmentObject var UserOptions : OptionsModel
    @State private var isDrag = false
    @State private var offSet = 0.0
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                ZStack{
                    Header_DayOfWeekView(week: UserOptions.prevWeek)
                        .frame(width: geometry.size.width)
                        .position(x: geometry.size.width * -0.5,y: 75/2) //x position based on center of view
                    Header_DayOfWeekView(week: UserOptions.currentWeek)
                        .frame(width: geometry.size.width)
                        .position(x: geometry.size.width / 2,y: 75/2)
                    Header_DayOfWeekView(week: UserOptions.nextWeek)
                        .frame(width: geometry.size.width)
                        .position(x: geometry.size.width * 1.5 ,y: 75/2)
                }
                .frame(height: 75,alignment: .leading)
                .animation(.easeInOut(duration: 0.3), value: UserOptions.selectedDay )
            }
        }
            .offset(x:offSet)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
                    .onChanged{
                        isDrag = true
                        let dist = $0.translation.width
                        offSet = dist
                        if abs(offSet) > 200 {
                            isDrag = false
                        }
                    }
                    .onEnded{
                        let dist = $0.translation.width
                        if dist < -200 {
                            UserOptions.updateNextWeek()
                        }
                        else if dist > 200 {
                            UserOptions.updatePrevWeek()
                        }
                        isDrag = false
                        offSet = 0
                    }
            )
    }
}

struct Header_ScrollTabView_Previews: PreviewProvider {
    static var previews: some View {
        Header_ScrollTabView().environmentObject(OptionsModel())
    }
}

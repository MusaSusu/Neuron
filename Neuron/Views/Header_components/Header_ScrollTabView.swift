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
        ZStack{
            HStack{
                Header_DayOfWeekView(week: UserOptions.prevWeek)
                    .frame(width: 400)
                    .position(x: -210,y: 75/2)
                Header_DayOfWeekView(week: UserOptions.currentWeek)
                    .frame(width: 400)
                    .position(x: 60,y: 75/2)
                Header_DayOfWeekView(week: UserOptions.nextWeek)
                    .frame(width: 400)
                    .position(x:310,y: 75/2)
            }
            .animation(.easeInOut(duration: 0.3), value: UserOptions.selectedDay )
            .frame(height: 75)
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

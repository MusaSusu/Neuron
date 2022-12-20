//
//  TimeLineItem.swift
//  Neuron
//
//  Created by Alvin Wu on 12/16/22.
//

import SwiftUI

struct TimeLineItemView: View {
    var item : TimeLineItemModel
    
    
    var body: some View {
        ZStack{
            Circle()
                .fill(item.color)
                .frame(width: 45,height: 45)
            Image(systemName:item.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(white:0.95))
                .frame(width: 30,height: 30)
        }
        .contentShape(.dragPreview, Circle())


    }
    
    func drawCapsule(date:Date,duration:TimeInterval) -> some View{
        TimelineView(.periodic(from: date, by: 30)){context in
            let value = max(0,context.date.timeIntervalSince(date) / duration)
            let gradient = Gradient(stops: [
                .init(color: item.color, location: 0),
                .init(color: Color(white: 0.95), location: value),
            ])
            ZStack{
                Circle()
                    .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 1.25) ) )
                    .frame(width: 45, height: 45)
                let gradient = Gradient(stops: [
                    .init(color: .white, location: 0),
                    .init(color: item.color, location: value),
                ])
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 2))
                    .mask(Image(systemName:item.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    ).frame(width: 30.0, height: 30.0)
            }
        }
    }
}

struct TimeLineItemView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineItemView(item:TimeLineItemModel(icon: "tray.fill",start: 50, duration: 120,color: .red))
    }
}

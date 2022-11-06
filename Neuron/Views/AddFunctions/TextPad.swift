//
//  TextPad.swift
//  Neuron
//
//  Created by Alvin Wu on 11/1/22.
//

import SwiftUI
import UIKit

struct TextPad: View {
    @StateObject var WheelItems =  WheelItemsModel(["habits", "routine","tasks"] )
    
    let items = ["habits", "routine","tasks"]
    @State private var index = 0
    @State private var datas: Color = Color.blue
    @State var isDragging = false
    @State var location: String = "none"

    
    let colors  = [Color.red,Color.blue,Color.yellow]
    var body: some View {
        VStack{
            HStack{
                Text("\(WheelItems.selection)")
            }
            GeometryReader{ geometry in
                let wDim = geometry.size.width
                WheelView(width:geometry.size.width,items:items, locations: [wDim/4,wDim/2, wDim * 3/4]).environmentObject(WheelItems)
            }
            .frame(width:.infinity,height:100)
        }
    }
}

struct TextPad_Previews: PreviewProvider {
    static var previews: some View {
        TextPad()
    }
}

private struct WheelItem: View {
    var title: String
    var coords: CGFloat
    
    var body: some View {
        VStack{
            Text("\(title)")
            Text("\(coords)")
            
        }
        .frame(width:100).border(.black)
        .position(x: coords, y: 50)
    }
}

struct WheelView: View {
    @EnvironmentObject var WheelItems: WheelItemsModel
    let width : CGFloat
    let items : [String]
    @State var locations : [CGFloat]
    @State var offset = 0.0
    
    init(width: CGFloat, items: [String],locations: [CGFloat]){
        self.width = width
        self.items = items
        self.locations = locations
    }

    
    var body: some View {
        HStack{
            ZStack{
                ForEach(0..<items.count, id:\.self) { index in
                    WheelItem(title: items[index], coords: locations[index])
                        .offset(x:offset)
                }
            }.coordinateSpace(name: "screen").border(.black)
        }.frame(width: width,height:100)
            .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .named("screen"))
                    .onChanged {var dist = $0.translation.width
                        dist = WheelItems.maxDrag(dist: dist)
                        offset = dist
                    }
                    .onEnded{_ in
                        locations = locations.map{$0 + (97.5 * CGFloat(Int(offset) / 80))}
                        offset = 0
                        WheelItems.computeSelection(items: locations)
                    }
            )
    }
}

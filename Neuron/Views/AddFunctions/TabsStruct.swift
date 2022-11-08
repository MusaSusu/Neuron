//
//  TextPad.swift
//  Neuron
//
//  Created by Alvin Wu on 11/1/22.
//

import SwiftUI
import UIKit

struct TabsStruct: View {
        
    @State var taskDuration : CGFloat = 30.0
    @State var taskColor: Color = Color.red
    @State var taskNotes: String = "notes"
    
    init(loc:Int){
        _WheelItems = StateObject(wrappedValue: WheelItemsModel(index: loc) )
    }
    
    @StateObject var WheelItems : WheelItemsModel

    
    var body: some View {
        VStack{
            Text("\(WheelItems.index)")
            GeometryReader{ geometry in
                let wDim = min( ((geometry.size.width)/10), 80)
                let hDim = geometry.size.height
                let delta = wDim*3
                let firstEle = wDim * 5
                HStack{
                    WheelView(
                        hcenter: hDim ,
                        wcenter:wDim*5,
                        delta:delta,
                        locations: [firstEle,firstEle + delta, firstEle + (2*delta),firstEle + (3*delta)],
                        offset: .init(repeating: 0, count: 4)
                    )
                    .environmentObject(WheelItems)
                }
            }.frame(minHeight: 40,maxHeight:60)
            
            Text("\(WheelItems.index)")

            
            HStack{
                TabView(selection: $WheelItems.index){
                     AddTaskView(
                        taskDuration: $taskDuration, taskColor: $taskColor, taskNotes: $taskNotes
                     ).tabItem{Label("Add Task", systemImage: "circle")
                         Text("ITEM")
                     }.tag(0)
                    AddRoutineTab(taskDuration: $taskDuration, taskColor: $taskColor, taskNotes: $taskNotes)
                        .tabItem{Label("Add Routine", systemImage: "circle")}.tag(1)
                    AddRoutineTab(taskDuration: $taskDuration, taskColor: $taskColor, taskNotes: $taskNotes)
                        .tabItem{Label("Add Habit", systemImage: "circle")}.tag(2)
                    AddRoutineTab(taskDuration: $taskDuration, taskColor: $taskColor, taskNotes: $taskNotes)
                        .tabItem{Label("Add Inbox", systemImage: "circle")}.tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .animation(.easeIn.speed(0.1),value: WheelItems.index)
                
            }
            Spacer()

        }.background(
            Color(white : 0.95)
        )
    }
}

struct TabsStruct_Previews: PreviewProvider {
    static var previews: some View {
        TabsStruct(loc: 1 )
    }
}

private struct WheelItem: View {
    @EnvironmentObject var WheelItems: WheelItemsModel
    var index: Int
    var title: String
    var coords: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack{
            Text("\(title)").font(.title).bold()
            Text("\(WheelItems.index)")
        }
        .position(x:coords,y:height/2)
        .offset(x:WheelItems.offset[index])
    }
}

private struct WheelView: View {
    @EnvironmentObject var WheelItems: WheelItemsModel
    let hcenter: CGFloat
    let wcenter : CGFloat
    let delta : CGFloat
    let leftMax : CGFloat
    @State var locations : [CGFloat]
    @State var isDrag: Bool = false
    
    init(hcenter: CGFloat ,wcenter: CGFloat,delta: CGFloat,locations: [CGFloat],offset: [CGFloat]){
        self.hcenter = hcenter
        self.wcenter = wcenter
        self.locations = locations
        self.delta = delta
        self.leftMax = {
            wcenter - (3 * delta)
        }()
    }
    
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                ContainerView(width: delta){
                    Rectangle()
                        .fill(isDrag ? .gray : .clear)
                        .animation(.easeIn.speed(isDrag ? 1.5 : 0.5), value: locations)
                }
            }
            .mask{
                ZStack{
                    ForEach(0..<4, id:\.self) { index in
                        WheelItem(index: index,
                                  title: WheelItems.options[index],
                                  coords: locations[index],
                                  height: hcenter
                        ).animation(.easeIn, value: locations)
                    }
                }.coordinateSpace(name: "screen")
            }
        }.gesture(
            DragGesture(minimumDistance: 5, coordinateSpace: .named("screen"))
                .onChanged{
                    isDrag = true
                    let dist = $0.translation.width
                    WheelItems.maxDrag(dist: dist, items: locations,delta: delta, center: wcenter, leftmax: leftMax)
                }
                .onEnded{
                    let dist = WheelItems.computeSelection(items: locations, dist: $0.translation.width,delta: delta)
                    locations = locations.map{$0 + dist}
                    WheelItems.offset = [0.0,0.0,0.0,0.0]
                    isDrag = false
                }
        )
    }
    private struct ContainerView<Content: View>: View{
        let width: CGFloat
        @ViewBuilder var content: Content

        var body: some View{
            content
                Rectangle()
                .fill(userColor)
                .frame(width: width)
            content
        }
    }
}


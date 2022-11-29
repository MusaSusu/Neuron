//
//  TextPad.swift
//  Neuron
//
//  Created by Alvin Wu on 11/1/22.
//

import SwiftUI
import UIKit

struct TabsStruct: View {
    @StateObject var WheelItems : WheelItemsModel
    @EnvironmentObject var NewItem: NewItemModel
    
    init(width : CGFloat){
        _WheelItems = StateObject(wrappedValue: WheelItemsModel(width: width) )
    }
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                HStack(spacing:0){
                    WheelView(hcenter: geometry.size.height).environmentObject(WheelItems)
                }
            }.frame(minHeight: 40,maxHeight:50)
            
            
            HStack{
                TabView(selection: $WheelItems.selection){
                    AddTaskTab().tabItem{Label("Add Task", systemImage: "circle")}.tag(0).environmentObject(NewItem)
                    AddRoutineTab()
                        .tabItem{Label("Add Routine", systemImage: "circle")}.tag(1)
                    AddRoutineTab()
                        .tabItem{Label("Add Habit", systemImage: "circle")}.tag(2)
                    AddRoutineTab()
                        .tabItem{Label("Add Inbox", systemImage: "circle")}.tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: WheelItems.selection)
                .onChange(of: WheelItems.selection){value in
                    NewItem.selection = value
                }
            }
        }.background(
            Color(white : 0.95)
        )
    }
}

struct TabsStruct_Previews: PreviewProvider {
    static var previews: some View {
        TabsStruct(width: 430)
            .environmentObject(DateListModel())
            .environmentObject(NewItemModel())
    }
}

private struct WheelItem: View {
    @EnvironmentObject var WheelItems: WheelItemsModel
    var index: Int
    var height: CGFloat
    
    var body: some View {
        VStack{
            Text("\(WheelItems.options[index])").font(.title).bold()
        }
        .frame(width: WheelItems.delta,height: height)
        .position(x:WheelItems.placements[index],y:height/2)
        .offset(x:WheelItems.offset[index])
    }
}

private struct WheelView: View {
    @EnvironmentObject var WheelItems: WheelItemsModel
    @State var isDrag: Bool = false
    
    let hcenter: CGFloat
    
    init(hcenter: CGFloat){
        self.hcenter = hcenter
    }
    
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                ContainerView(width: WheelItems.delta){
                    Rectangle()
                        .fill(isDrag ? .gray : .clear)
                        .animation(.easeIn.speed(isDrag ? 1.5 : 0.5), value: WheelItems.selection)
                }
            }
            .mask{
                ZStack{
                    ForEach(0..<4, id:\.self) { index in
                        WheelItem(index: index,height: hcenter)
                            .animation(.easeIn,value: WheelItems.selection)
                    }
                }
            }
        }.coordinateSpace(name: "screen")
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
                .onChanged{
                    isDrag = true
                    let dist = $0.translation.width
                    WheelItems.applyOffset(dist)
                }
                .onEnded{
                    WheelItems.computeSelection(dist: $0.translation.width)
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


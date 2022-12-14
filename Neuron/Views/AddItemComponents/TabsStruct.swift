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
    @EnvironmentObject var NewItem : NewItemModel
    @State var transitionHelper: Bool = false
    let viewSelection: [[widgets]] = [TaskWidgets,ProjectWidgets,[.ColorPicker,.DurationPicker,.Notes],RoutineWidgets]
    
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
                if transitionHelper{
                    
                    GenericTabView(widgetsToLoad: viewSelection[WheelItems.selection])
                        .transition(.asymmetric(insertion: .push(from: .leading), removal: .push(from: .trailing)))
                }
                else{
                    
                    GenericTabView(widgetsToLoad: viewSelection[WheelItems.selection])
                        .transition(.asymmetric(insertion: .push(from: .leading), removal: .push(from: .trailing)))
                }
            }
            .animation(.easeInOut, value: transitionHelper)
            .onChange(of: WheelItems.selection){ value in
                    NewItem.selection = value
                transitionHelper.toggle()
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
            .environmentObject(ProjectModel())
            .environmentObject(RoutineViewModel())
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


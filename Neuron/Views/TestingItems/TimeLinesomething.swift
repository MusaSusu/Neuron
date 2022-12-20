//
//  TimeLinesomething.swift
//  Neuron
//
//  Created by Alvin Wu on 12/16/22.
//

import SwiftUI

struct TimeLinesomething: View {
    @StateObject var items = TimeLineModel(items: [])
    @State var selectionMenu : MainWidgets = .none

    
    init(items: [TimeLineItemModel] ) {
        _items = .init(wrappedValue: TimeLineModel(items: items))
    }
    
    @State private var draggedItem: TimeLineItemModel?
    
    let height = 60 * 16 * 1.5
    
    var body: some View {
        ScrollView(.vertical){
            Spacer()
            VStack( spacing: 0){
                ZStack{
                    ForEach(items.items, id: \.self.id){item in
                        TimeLineItemView(item: item)
                            .onDrag{
                                self.draggedItem = item
                                return NSItemProvider()
                            }
                            .onDrop(of: [.text],
                                    delegate: DropViewDelegate(destinationItem: item, items: $items.items, draggedItem: $draggedItem)
                            )
                            .position(x:30,y:item.start)
                        
                    }
                }
            }.frame(width:60,height: (60 * 1.5 * 16))
        }.scrollDisabled(true)
    }
}

struct TimeLinesomething_Previews: PreviewProvider {
    static var previews: some View {
        TimeLinesomething(items:[TimeLineItemModel(icon: "tray.fill", start:10,duration:100,color: .red),TimeLineItemModel(icon: "tray.fill",start: 200, duration: 200,color:.black),TimeLineItemModel(icon: "tray.fill",start:300,duration:100,color: .orange)])
    }
}

//
//  SelectionMenuBuilderView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/14/23.
//

import SwiftUI
import CoreData

struct SelectionMenuBuilderView<T: NSManagedObject & isTimelineItem>: View {
    @ObservedObject var task : T
    @Binding var selectionMenu : MenuWidgets
    let capsuleHeight : CGFloat
    var menuItems : [MenuWidgets] = []
    
    var body: some View {
        VStack{
            Spacer()
            switch selectionMenu {
            case .description:
                TaskDescriptionView(task: task,capsuleHeight: capsuleHeight )
                    .transition(.scale)
            case .none:
                TimeLineTitleView(task: task)
            case .menu:
                TimeLineTitleView(task: task)
                TimeLineMenu(selectedMenu: $selectionMenu)
                    .transition(.scale(scale: 0,anchor: UnitPoint(x: 0 , y: 0.5)))
                
            }
            Spacer()
        }
        .animation(.easeInOut(duration: 0.2), value: selectionMenu)
        .padding(.leading,5)
        
    }
}

struct SelectionMenuBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionMenuBuilderView<Tasks>(task: previewscontainer,selectionMenu: .constant(.menu),capsuleHeight: 100)
    }
}

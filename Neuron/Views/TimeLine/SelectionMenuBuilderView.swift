//
//  SelectionMenuBuilderView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/14/23.
//

import SwiftUI
import CoreData

struct MenuWidgets: OptionSet{
    let rawValue: Int
    
    static let none = MenuWidgets(rawValue: 1 << 0)
    static let menu = MenuWidgets(rawValue: 1 << 1)
    static let description = MenuWidgets(rawValue: 1 << 2)
}

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
                TaskDescriptionView(task: task,capsuleHeight: capsuleHeight,content: buildTitleView )
                    .transition(.scale)
            case .none:
                buildTitleView()
            case .menu:
                buildTitleView()
                TimeLineMenu(selectedMenu: $selectionMenu)
                    .transition(.scale(scale: 0,anchor: UnitPoint(x: 0 , y: 0.5)))
            default:
                EmptyView()
            }
            Spacer()
        }
        .animation(.easeInOut(duration: 0.2), value: selectionMenu)
        .padding(.leading,5)
        
    }
    func buildTitleView() -> some View{
        TimeLineTitleView(task: task,content: taskChecker)
    }
    func taskChecker() -> some View {
        Button {
            task.taskChecker.toggle()
        } label: {
            Label {Text("Task Complete?")} icon: {
                Image(systemName: task.taskChecker ? "circle.inset.filled" : "circle")
                    .foregroundColor(task.taskChecker ? task.color?.fromDouble().opacity(1) : .secondary)
                    .accessibility(label: Text(task.taskChecker ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }.labelStyle(.iconOnly)
    }
    
    @ViewBuilder
    func buildView() -> some View{
        
    }
}

struct SelectionMenuBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionMenuBuilderView<Tasks>(task: previewscontainer,selectionMenu: .constant(.menu),capsuleHeight: 100)
    }
}

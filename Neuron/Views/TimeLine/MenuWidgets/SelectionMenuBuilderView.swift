//
//  SelectionMenuBuilderView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/14/23.
//

import SwiftUI
import CoreData

enum MenuWidgets: Int,Hashable,Identifiable{
    
    var id : Int{return rawValue}
    
    case none = 0,
         menu,
         description,
         routine_completion
}

struct SelectionMenuBuilderView<T: NSManagedObject & isTimelineItem,content : View>: View {

    @ObservedObject var task : T
    @Binding var selectionMenu : MenuWidgets
    var menuItems : [MenuWidgets]
    @ViewBuilder var TaskButtonView : () -> content
    
    @Binding var taskChecker : Bool
    @State var helperChecker : Bool = true // to refresh view
    
    let capsuleHeight : CGFloat
    let dateInterval : DateInterval
    
    init(task:T, selectionMenu: Binding<MenuWidgets>, menuItems: [MenuWidgets], taskChecker: Binding<Bool>, capsuleHeight: CGFloat, dateInterval : DateInterval,
         TaskButtonView : @escaping () -> content  ) {
        _selectionMenu = selectionMenu
        _taskChecker = taskChecker
        self.capsuleHeight = capsuleHeight
        self.dateInterval = dateInterval
        self.task = task
        self.menuItems = menuItems
        self.TaskButtonView = TaskButtonView
    }
    
    var body: some View {
        VStack{
            Spacer()
            switch selectionMenu {
            case .description:
                DescriptionView(task: task, capsuleHeight: capsuleHeight, content: TitleView)
                    .transition(.scale)
            case .none:
                TitleView()
            case .menu:
                TitleView()
                TimeLineMenu(selectedMenu: $selectionMenu, menuItems: menuItems, taskButtonView: TaskButtonView)
                    .transition(.scale(scale: 0,anchor: UnitPoint(x: 0 , y: 0.5)))
            case .routine_completion:
                Menu_Routine_CompletetionView(Item: task as! Routine)
            }
            Spacer()
        }
        .animation(.easeInOut(duration: 0.2), value: selectionMenu)
        .padding(.leading,5)
    }

    func TitleView() -> some View {
        HStack(alignment:.center,spacing:0){
            
            HStack(spacing:0) {
                Text("\(task.title!)")
                    .font(.system(.title3,weight:.semibold))
                
                Text("(\( dateInterval.duration.toHourMin(from: .seconds) ))")
                    .font(.system(.subheadline,weight: .light).italic())
            }
            .overlay(
                strikethroughs()
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .fill(taskChecker ? .red : .clear)
            )
            Spacer()
            Button {
                helperChecker.toggle()
                taskChecker.toggle()
            } label: {
                Label {Text("Task Complete?")} icon: {
                    Image(systemName: taskChecker ? "circle.inset.filled" : "circle")
                        .foregroundColor(taskChecker ? task.color?.fromDouble() : .secondary)
                        .accessibility(label: Text(taskChecker ? "Checked" : "Unchecked"))
                        .imageScale(.large)
                }
            }.labelStyle(.iconOnly)
        }
    }
    
    struct strikethroughs: Shape{
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: (rect.minX-5), y: (rect.midY)  ))
            path.addLine(to: CGPoint(x:(rect.maxX+5), y: (rect.midY) ))
            
            return path
        }
    }
}

struct SelectionMenuBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionMenuBuilderView<Tasks,Menu_Card_Button>(
            task: previewsTasks,
            selectionMenu: .constant(.menu),
            menuItems: [.menu,.description,.none],
            taskChecker: .init(get: {previewsTasks.taskChecker},
                               set: {newValue in
                                   previewsTasks.taskChecker = newValue}
                              ),
            capsuleHeight: 100,
            dateInterval: previewsTasks.dateInterval,
            TaskButtonView: {Menu_Card_Button(Item: previewsTasks,
                                              menuSelection: .Notes,
                                              menuItems: [.DateCard(.Task),.Notes])
                
            }
        )
    }
}

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
         Routine_Completion

}

struct SelectionMenuBuilderView<T: NSManagedObject & isTimelineItem>: View {

    @ObservedObject var task : T
    @Binding var selectionMenu : MenuWidgets
    var menuItems : [MenuWidgets]

    
    @Binding var taskChecker : Bool
    @State var helperChecker : Bool = true
    
    let capsuleHeight : CGFloat
    let dateInterval : DateInterval
    
    init(task:T, selectionMenu: Binding<MenuWidgets>,menuItems: [MenuWidgets], taskChecker: Binding<Bool>, capsuleHeight: CGFloat,dateInterval : DateInterval ) {
        _selectionMenu = selectionMenu
        _taskChecker = taskChecker
        self.capsuleHeight = capsuleHeight
        self.dateInterval = dateInterval
        self.task = task
        self.menuItems = menuItems
    }
    
    
    var body: some View {
        VStack{
            Spacer()
            switch selectionMenu {
            case .description:
                TaskDescriptionView(task: task,capsuleHeight: capsuleHeight,content: TitleView )
                    .transition(.scale)
            case .none:
                TitleView()
            case .menu:
                TitleView()
                TimeLineMenu(selectedMenu: $selectionMenu, menuItems: menuItems, taskButtonView: TaskButtonView)
                    .transition(.scale(scale: 0,anchor: UnitPoint(x: 0 , y: 0.5)))
            case .Routine_Completion:
                Menu_Routine_CompletetionView(Item: task as! Routine)
            }
            Spacer()
        }
        .animation(.easeInOut(duration: 0.2), value: selectionMenu)
        .padding(.leading,5)
    }

    @ViewBuilder
    func TitleView() -> some View {
        HStack(alignment:.center,spacing:0){
            
            HStack(spacing:0) {
                Text("\(task.title!)")
                    .font(.system(.title3,design: .default,weight:.semibold))
                
                Text("  (\( dateInterval.duration.toHourMin(from: .seconds) ))")
                    .italic()
                    .font(.system(.subheadline,weight: .light))
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
                        .foregroundColor(taskChecker ? task.color?.fromDouble().opacity(1) : .secondary)
                        .accessibility(label: Text(taskChecker ? "Checked" : "Unchecked"))
                        .imageScale(.large)
                }
            }.labelStyle(.iconOnly)
        }
    }
    
    @ViewBuilder
    func TaskButtonView() -> some View{
        Menu_TaskCard_View(Task: task)
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
        SelectionMenuBuilderView<Tasks>(
            task: previewsTasks,
            selectionMenu: .constant(.menu),
            menuItems: [.menu,.description,.none],
            taskChecker: .init(get: {previewsTasks.taskChecker},
                               set: {newValue in
                                   previewsTasks.taskChecker = newValue}
                              ),
            capsuleHeight: 100,
            dateInterval: previewsTasks.dateInterval
        )
    }
}

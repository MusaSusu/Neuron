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
    @Binding var taskChecker : Bool
    @State var helperChecker : Bool = true
    let capsuleHeight : CGFloat
    var menuItems : [MenuWidgets] = [.menu]
    let dateInterval : DateInterval
    
    init(task:T, selectionMenu: Binding<MenuWidgets>, taskChecker: Binding<Bool>, capsuleHeight: CGFloat,dateInterval : DateInterval ) {
        _selectionMenu = selectionMenu
        _taskChecker = taskChecker
        self.capsuleHeight = capsuleHeight
        self.dateInterval = dateInterval
        self.task = task
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
    func buildView() -> some View{
        
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
        SelectionMenuBuilderView<Tasks>( task: previewscontainer, selectionMenu: .constant(.menu), taskChecker: .init(get: {previewscontainer.taskChecker}, set: {newValue in previewscontainer.taskChecker = newValue}),capsuleHeight: 100, dateInterval: previewscontainer.dateInterval)
    }
}

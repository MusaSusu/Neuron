//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/22/23.
//

import SwiftUI
import UniformTypeIdentifiers

let testItems : TimelineItemsArray = .init(combinedarray:[
    (TimelineItemWrapper(previewscontainer, date: previewscontainer.dateInterval, type: .task),
     .init(get: {previewscontainer.taskChecker}, set: {newVal in previewscontainer.taskChecker = newVal})
     ),
    (TimelineItemWrapper(previewscontainer, date: previewscontainer.dateInterval, type: .task),
     .init(get: {previewscontainer.taskChecker}, set: {newVal in previewscontainer.taskChecker = newVal})
    )
    ]
                                           )
                                           

struct TimeLineListBuilderView: View {
        
    @ObservedObject var arrayobjects : TimelineItemsArray
    @ObservedObject var dragged = DropViewHelper.shared
    @State var selection : TimelineItemWrapper?
    
    var body: some View {
        VStack(spacing: 0){
            ForEach($arrayobjects.array, id:\.hashValue){$item in
                CheckTypeContainer(
                    item: $item,
                    taskChecker: arrayobjects.taskCheckerDict[item.id]!,
                    nextDuration: arrayobjects.getNextDuration(at:(item.index)/2)
                )
                .onDrag({
                    selection = item
                    dragged.dragged = item
                    arrayobjects.copyforDrop = arrayobjects.array
                    return NSItemProvider(object: NSString())
                    })
                .onDrop(
                    of: [.plainText],
                    delegate: DropViewDelegate(
                        destinationItem: item,
                        itemsArray: arrayobjects,
                        draggedItem: $selection)
                )
            }
        }
    }
    
    struct CheckTypeContainer : View{
        @Environment(\.managedObjectContext) private var viewContext
        @State var selectionMenu : MenuWidgets = .menu
        @Binding var item : TimelineItemWrapper
        @Binding var taskChecker : Bool

        let nextDuration : TimeInterval
        
        var capsuleHeight: CGFloat{
            let duration = abs((CGFloat(item.duration) / 1800))
            if duration <= 1 {
                return 90
            }
            else if duration >= 6 {
                return 480
            }
            else {
                return duration * 80
            }
        }
        
        var nextDurationHeight: Double{
                if nextDuration < 1 {
                    return 5
                }
                else if nextDuration / 3600 < 0.5 {
                    return 25
                }
                else if nextDuration / 3600 < 1{
                    return 50
                }
                return 75
        }
        
        var nextDurationText : String{
            if nextDuration < 1{
                return ""
            }
            return nextDuration.toHourMin(from: .seconds)
        }
        
        
        var body: some View{
            HStack{
                HStack(spacing: 0){
                    CapsuleRowView(task: $item, nextDuration: nextDurationHeight, widgetsArray: [.menu],capsuleHeight: capsuleHeight, selectionMenu: $selectionMenu)
                    selectTypeForSelectionMenuView(type: item.type)
                }.frame(height: capsuleHeight)
                
                HStack{
                    Text(nextDurationText)
                }.frame(height: nextDurationHeight)
            }
            .background(Color(white: 0.99))
            //background to allow hittest on white background
            
        }
        @ViewBuilder
        func selectTypeForSelectionMenuView(type: taskType) -> some View{
            if type == .task{
                let Task = viewContext.object(with: item.id) as! Tasks
                SelectionMenuBuilderView(task: Task,selectionMenu: $selectionMenu, taskChecker: $taskChecker, capsuleHeight: capsuleHeight, dateInterval: item.dateInterval as DateInterval)
            }
            else{
                let Routine = viewContext.object(with: item.id) as! Routine
                SelectionMenuBuilderView(task: Routine ,selectionMenu: $selectionMenu, taskChecker: $taskChecker, capsuleHeight: capsuleHeight, dateInterval: item.dateInterval as DateInterval)
            }
        }
    }
}



struct TimeLineListBuilder_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineListBuilderView(arrayobjects: testItems)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)

    }
}

extension TimeLineListBuilderView{
    init(arrayobjects:  [ (TimelineItemWrapper, Binding<Bool> ) ]) {
        var array : TimelineItemsArray = .init(combinedarray: arrayobjects)
        array.initIndexes()
        array.sortArray()
        _arrayobjects = .init(initialValue: array)
    }
}

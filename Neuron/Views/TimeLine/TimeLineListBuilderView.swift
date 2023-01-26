//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/22/23.
//

import SwiftUI

let testItems : timelineitemsarray = .init(array:[
    (timelineItemWrapper(previewscontainer, date: previewscontainer.dateInterval, type: .task),
     .init(get: {previewscontainer.taskChecker}, set: {newVal in previewscontainer.taskChecker = newVal})
     ),
    (timelineItemWrapper(previewscontainer, date: previewscontainer.dateInterval, type: .task),
     .init(get: {previewscontainer.taskChecker}, set: {newVal in previewscontainer.taskChecker = newVal})
    )
    ]
                                           )
                                           

struct TimeLineListBuilderView: View {
        
    @ObservedObject var arrayobjects : timelineitemsarray
    @State var selection : Int?
    
    var body: some View {
        VStack(spacing: 0){
            ForEach($arrayobjects.array,id:\.self.0, editActions: [.move]){$item in
                CheckTypeContainer(item: item.0, taskChecker: item.1, nextDuration: arrayobjects.getNextDuration(index: (item.0.index)/2 ))
                    .onDrag({
                        selection = item.0.index
                        return NSItemProvider()
                    })
                    .onDrop(of: [.item], delegate: DropViewDelegate(destinationItem: item.0.index, items: arrayobjects, draggedItem: $selection))
            }
        }
    }
    
    struct CheckTypeContainer : View{
        @Environment(\.managedObjectContext) private var viewContext
        @State var selectionMenu : MenuWidgets = .menu
        let item : timelineItemWrapper
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
                HStack(spacing: 0){
                    CapsuleRowView(task: item, nextDuration: nextDurationHeight , date: item.dateInterval, widgetsArray: [.menu],capsuleHeight: capsuleHeight, selectionMenu: $selectionMenu)
                    selectTypeForSelectionMenuView(type: item.type)
                }.frame(height: capsuleHeight)
                
                HStack{
                    Text(nextDurationText)
                }.frame(height: nextDurationHeight)
            
        }
        @ViewBuilder
        func selectTypeForSelectionMenuView(type: taskType) -> some View{
            if type == .task{
                let Task = viewContext.object(with: item.id) as! Tasks
                SelectionMenuBuilderView(task: Task,selectionMenu: $selectionMenu, taskChecker: $taskChecker, capsuleHeight: capsuleHeight, dateInterval: item.dateInterval)
            }
            else{
                let Routine = viewContext.object(with: item.id) as! Routine
                SelectionMenuBuilderView(task: Routine ,selectionMenu: $selectionMenu, taskChecker: $taskChecker, capsuleHeight: capsuleHeight, dateInterval: item.dateInterval)
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
    init(arrayobjects:  [ (timelineItemWrapper, Binding<Bool> ) ]) {
        let array : timelineitemsarray = .init(array: arrayobjects)
        array.initIndexes()
        array.sortArray()
        _arrayobjects = .init(initialValue: array)
    }
}

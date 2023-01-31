//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/22/23.
//

import SwiftUI
import UniformTypeIdentifiers

#if targetEnvironment(simulator)
let testItems : TimelineItemsArray = .init(combinedarray:[
    (TimelineItemWrapper(previewscontainer, date: previewscontainer.dateInterval, type: .task),
     .init(get: {previewscontainer.taskChecker}, set: {newVal in previewscontainer.taskChecker = newVal})
    ),
    (TimelineItemWrapper(previewscontainer, date: previewscontainer.dateInterval, type: .task),
     .init(get: {previewscontainer.taskChecker}, set: {newVal in previewscontainer.taskChecker = newVal})
    )
]
)
#endif

                                           

struct TimeLineListBuilderView: View {
    @Environment(\.editMode) private var editMode
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
                .if(editMode?.wrappedValue.isEditing == true){view in
                    view
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
    }
    
    struct CheckTypeContainer : View{
        @Environment(\.managedObjectContext) private var viewContext
        @Environment(\.editMode) private var editMode
        
        @State var selectionMenu : MenuWidgets = .menu
        @Binding var item : TimelineItemWrapper
        @Binding var taskChecker : Bool
        @State var offsetAmt : CGFloat = 0


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
            VStack(spacing: 0){
                HStack(spacing: 0){
                        CapsuleRowView(
                            task: $item,
                            nextDuration: nextDurationHeight,
                            capsuleHeight: capsuleHeight,
                            selectionMenu: $selectionMenu
                        )
                        .modifier(ShakeEffect(shakeNumber: offsetAmt)) //Shake effect when `editmode` is `true`.
                        .onAppear{
                            withAnimation(.linear(duration: 0.1).repeatForever(autoreverses:true)) {
                                if (editMode?.wrappedValue.isEditing == true){
                                    offsetAmt = 0.5
                                }
                            }
                        }
                        .if(editMode?.wrappedValue.isEditing == false){view in
                            view    
                                .onLongPressGesture(minimumDuration: 2){
                                    editMode?.wrappedValue = .active
                                }
                        }

                    SelectTypeForSelectionMenuView(type: item.type)
                }
                .frame(height: capsuleHeight)
                
                
                HStack{
                }.frame(height: nextDurationHeight)
            }
            .background(Color(white: 0.99))
            //background to allow hittest on white background
            
        }
        @ViewBuilder
        func SelectTypeForSelectionMenuView(type: taskType) -> some View{
            if type == .task{
                let Task = viewContext.object(with: item.id) as! Tasks
                SelectionMenuBuilderView(
                    task: Task,
                    selectionMenu: $selectionMenu,
                    menuItems: [.description],
                    taskChecker: $taskChecker,
                    capsuleHeight: capsuleHeight,
                    dateInterval: item.dateInterval as DateInterval)
            }
            else{
                let Routine = viewContext.object(with: item.id) as! Routine
                SelectionMenuBuilderView(
                    task: Routine,
                    selectionMenu: $selectionMenu,
                    menuItems: [.Routine_Completion,.description],
                    taskChecker: $taskChecker,
                    capsuleHeight: capsuleHeight,
                    dateInterval: item.dateInterval as DateInterval)
            }
        }
    }
    struct ShakeEffect: AnimatableModifier {
        var shakeNumber: CGFloat = 0
        
        var animatableData: CGFloat {
            get {
                shakeNumber
            } set {
                shakeNumber = newValue
            }
        }
        
        func body(content: Content) -> some View {
            content
                .offset(x:shakeNumber,y: shakeNumber)
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

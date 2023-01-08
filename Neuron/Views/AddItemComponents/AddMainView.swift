//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/27/22.
//

import SwiftUI
import CoreData

struct AddMainView: View {
    @ObservedObject var item: Tasks // task object in child context
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss // causes body to run
    
    @StateObject var Task_Add = TaskModel_Add()
    @StateObject var NewItem_Add = NewItemModel()
    @StateObject var Project_Add = ProjectModel_Add()
    @StateObject var Routine_Add = RoutineModel_Add()
    @StateObject var Habit_Add = HabitModel_Add()
    
    @State var errorMessage: String?
    @State private var isFocused: Bool = false
    
    var body: some View {
        ZStack{
            
            VStack{
                //Header
                HStack{
                    Button{
                        dismiss()
                    } label: {
                        Text("Cancel").font(.title3.bold())
                            .foregroundColor(userColor)
                    }
                    Spacer()
                    Button{
                        addObject()
                        try? context.save()
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.title3.bold())
                            .foregroundColor(userColor)
                    }
                }.padding(.top)
                
                Divider()
                    .background(.blue)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                // NewItemTitle
                SearchView_().environmentObject(NewItem_Add)
                
                //TABSView
                GeometryReader{geometry in
                    TabsStruct(width:geometry.size.width)
                        .environmentObject(Task_Add)
                        .environmentObject(NewItem_Add)
                        .environmentObject(Routine_Add)
                        .environmentObject(Project_Add)
                        .environmentObject(Habit_Add)
                }.padding(.horizontal,-5)
                
            }
            .padding(10)
            .background(
                Color(white : 0.95)
            )
            .opacity(NewItem_Add.isPop != .none ? 0.5 : 1)
            .disabled(NewItem_Add.isPop != .none)
            
            showPop()
        }
    }
    
    @ViewBuilder
    func showPop()-> some View{
        switch NewItem_Add.isPop{
        case .DatePop:
            DatePickerSheet(){NewItem_Add.isPop = .none}
                .environmentObject(Task_Add)
                .transition(.asymmetric(insertion: .scale, removal: .scale))
        case .RoutinePop:
            EmptyView()
        case .none:
            EmptyView()
        }
    }
    
    func addObject(){
        
        switch NewItem_Add.selection{
        case 0:
            saveTask(dates: Task_Add.returnDates())
        case 2:
            saveHabit()
        default:
            saveTask(dates: Task_Add.returnDates())
        }
    }
    
    func saveHabit(){
        let newHabit = Habit(context: context)
        newHabit.id = UUID()
        newHabit.title = NewItem_Add.name
        newHabit.icon = NewItem_Add.icon
        newHabit.duration = NewItem_Add.duration
        newHabit.color = NewItem_Add.color.toDouble()
        newHabit.timeFrame = Habit_Add.timeFrame.rawValue
        newHabit.completed = 0
        newHabit.frequency = Int16(Habit_Add.selectedFreq)
        newHabit.notes = NewItem_Add.notes
    }
    
    func saveTask(dates: [Date]){
        item.id = UUID()
        item.title = NewItem_Add.name
        item.icon = NewItem_Add.icon
        item.duration = NewItem_Add.duration
        item.color = NewItem_Add.color.toDouble()
        item.taskChecker = false
        for date in dates {
            let taskGroup = DateEntity(context: context)
            let taskDate = TaskDate(context: context)
            
            taskGroup.dateGroup = date.startOfDay()
            taskGroup.addToHasTask(item)
            
            taskDate.task = item
            taskDate.date = date
            taskDate.dateGroup = taskGroup
        }
    }
}

struct AddMainView_Previews: PreviewProvider {
    static var previews: some View {
        AddMainView( item: .init(entity: Tasks.entity(),insertInto: PersistenceController.preview.container.viewContext))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}

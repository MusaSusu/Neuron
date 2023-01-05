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
    
    @StateObject var DateList = DateListModel()
    @StateObject var NewItem = NewItemModel()
    @StateObject var Project = ProjectModel()
    @StateObject var Routine = RoutineModel()
        
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
                SearchView_().environmentObject(NewItem)
                
                //TABSView
                GeometryReader{geometry in
                    TabsStruct(width:geometry.size.width)
                        .environmentObject(DateList)
                        .environmentObject(NewItem)
                        .environmentObject(Routine)
                        .environmentObject(Project)
                }.padding(.horizontal,-5)
                
            }
            .padding(10)
            .background(
                Color(white : 0.95)
            )
            .opacity(NewItem.isPop != .none ? 0.5 : 1)
            .disabled(NewItem.isPop != .none)
            
            showPop()
        }
    }
    
    
    func addObject(){
        
        switch NewItem.selection{
        case 0:
            saveItem(dates: DateList.returnDates())
        default:
            saveItem(dates: DateList.returnDates())
        }
    }
    
    @ViewBuilder
    func showPop()-> some View{
        switch NewItem.isPop{
        case .DatePop:
            DatePickerSheet(){NewItem.isPop = .none}
                .environmentObject(DateList)
                .transition(.asymmetric(insertion: .scale, removal: .scale))
        case .RoutinePop:
            EmptyView()
        case .none:
            EmptyView()
        }
    }
    
    func saveItem(dates : [Date]){
        item.id = UUID()
        item.title = NewItem.name
        item.icon = NewItem.icon
        item.duration = NewItem.duration
        item.color = NewItem.color.toDouble()
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
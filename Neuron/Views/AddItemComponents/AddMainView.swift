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
    @StateObject var RoutineModel = RoutineViewModel()

    @State var errorMessage: String?
    @State private var isFocused: Bool = false

    var body: some View {
        ZStack{
            
            ShowModal(isOn: DateList.isPop){
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
                            DateList.isPop.toggle()
                        } label: {
                            Text("Save").font(.title3.bold())
                                .foregroundColor(userColor)
                        }
                    }.padding(.top)
                    
                    Divider()
                        .background(.blue)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    // NewItemTitle
                    
                    HStack{
                        ZStack{
                            Circle().fill(NewItem.color).frame(width: 40)
                            Rectangle().fill(.white).mask{
                                Image(systemName:NewItem.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }.frame(width: 25.0, height: 25.0)
                        }.frame(width: 40).offset(x:10)
                        TextField(
                            "Something to do...",
                            text: $NewItem.name,
                            onEditingChanged: {_ in isFocused.toggle()}
                        ).customStyle()
                    }
                    .background{
                        ZStack{
                            RoundedRectangle(cornerRadius: 25,style: .continuous)
                                .fill(Color(white:0.99))
                            RoundedRectangle(cornerRadius: 25,style: .continuous)
                                .strokeBorder(
                                    userColor,
                                    lineWidth: isFocused ? 4 : 2
                                )
                        }.frame(height: 60)
                    }.frame(height: 80)
                    
                    //TABSView
                    GeometryReader{geometry in
                        TabsStruct(width:geometry.size.width)
                            .environmentObject(DateList)
                            .environmentObject(NewItem)
                            .environmentObject(RoutineModel)
                            .environmentObject(Project)
                        
                    }.padding(.horizontal,-5)
                    
                }
                .padding(10)
                .background(
                    Color(white : 0.95)
                )
            }
            
            VStack{
                if DateList.isPop{
                    
                    DatePickerDisc().environmentObject(DateList)
                        .transition(.asymmetric(insertion: .scale, removal: .scale))
                }
            }.animation(.default.speed(1), value: DateList.isPop)
            
        }
    }

    private func addObject(){
        item.id = UUID()
        item.title = NewItem.name
        item.icon = NewItem.icon
        item.dateStart = NewItem.dateStart
        item.dateEnd = NewItem.dateEnd
        item.duration = NewItem.duration
        item.color = NewItem.color.toDouble()
        item.taskChecker = false
        item.taskInfo = NewItem.notes
        item.taskDay = extractDate(date: NewItem.dateStart, format: "MM-dd-yyyy")
    }
    
    struct ShowModal<Content:View>: View{
        var isOn : Bool

        @ViewBuilder var content : Content
        
        var body: some View {
            VStack{
                content
                    .opacity(isOn ? 0.5 : 1)
                    .disabled(isOn)
            }
        }
    }
}

struct AddMainView_Previews: PreviewProvider {
    static var previews: some View {
        AddMainView( item: .init(entity: Tasks.entity(), insertInto: PersistenceController.preview.container.viewContext))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}

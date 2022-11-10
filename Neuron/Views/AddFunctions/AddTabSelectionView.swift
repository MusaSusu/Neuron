//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/27/22.
//

import SwiftUI
import CoreData

struct AddTabSelectionView: View {
    @ObservedObject var item: Tasks // task object in child context
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss // causes body to run
    @State var errorMessage: String?
    @State private var isFocused: Bool = false
    
    @State private var taskName: String = ""
    @State private var dateStart: Date = Date.now
    @State private var dateEnd: Date = Date.now.advanced(by: 300)
    @State private var taskColor: Color = Color(red: 0.5, green: 0.6039,  blue:0.8039)
    @State private var taskNotes: String = ""
    @State private var icon: String = "gift.fill"
    @State private var taskDuration: CGFloat = 30

    
    
    var body: some View {
        VStack{
            //TITLE / SEARCH
            HStack{
                Spacer()
                Text("Add Task").font(.title.bold())
                    .foregroundColor(userColor)
                Spacer()
                Button("Save") {
                    addObject()
                    try? context.save()
                    errorMessage = nil
                    dismiss()
                }
            }.padding(.top)
            
            Divider()
                .background(.blue)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            //MARK: Search Bar / Title Input
            
            HStack{
                ZStack{
                    Circle().fill(taskColor).frame(width: 40)
                    Rectangle().fill(.white).mask{
                        Image(systemName:icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.frame(width: 25.0, height: 25.0)
                }.frame(width: 40).offset(x:10)
                TextField(
                    "Something to do...",
                    text: $taskName,
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
                TabsStruct(width:geometry.size.width,taskDuration: $taskDuration, taskColor: $taskColor, taskNotes: $taskNotes)
                
            }.padding(.horizontal,-5)
            
        }
        .padding(10)
        .background(
            Color(white : 0.95)
        )
    }

    private func addObject(){
        item.id = UUID()
        item.title = taskName
        item.icon = icon
        item.dateStart = dateStart
        item.dateEnd = dateEnd
        item.duration = dateEnd.timeIntervalSince(dateStart) / 3600
        item.color = taskColor.toDouble()
        item.taskChecker = false
        item.taskInfo = taskNotes
        item.taskDay = extractDate(date: dateStart, format: "MM-dd-yyyy")
    }
}

struct AddTabSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTabSelectionView( item: .init(entity: Tasks.entity(), insertInto: PersistenceController.preview.container.viewContext))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}

extension TextField {
    func customStyle() -> some View {
        self
            .foregroundColor(.black)
            .font(.title2.weight(.regular))
            .padding(.vertical,10)
            .padding(.horizontal, 14)
    }
}

extension Divider{
    func format() -> some View {
        self
            .frame(height:1)
            .background(Color(red: 0.5, green: 0.6039,  blue:0.8039))
            .padding(5)
    }
}

extension Text{
    func titleFont() -> Self{
        self
            .font(.title2.bold()).foregroundColor(.black)
    }
}

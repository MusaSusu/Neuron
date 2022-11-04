//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/27/22.
//

import SwiftUI
import CoreData

struct AddTaskView: View {
    @ObservedObject var item: Tasks // task object in child context
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss // causes body to run
    @State var errorMessage: String?
    @State private var taskName: String = ""
    @State private var isFocused: Bool = false
    @State private var dateStart: Date = Date.now
    @State private var dateEnd: Date = Date.now.advanced(by: 300)
    @State private var taskColor: Color = Color(red: 0.5, green: 0.6039,  blue:0.8039)
    @State private var fullText: String = ""
    @State private var icon: String = "gift.fill"
    
    
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                Text("Add Task").font(.title.bold())
                    .foregroundColor(userColor)
                Spacer()
                Button("Save") {
                    addObject()
                    try? context.save()
                    dismiss()
                }
            }.padding(.vertical)
            
            Divider()
                .background(.blue)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            //MARK: Search Bar / Title Input
            HStack{
                TextField(
                    "Something to do...",
                    text: $taskName,
                    onEditingChanged: {_ in isFocused.toggle()}
                )
                .customStyle()
                .background{
                    ZStack{
                        RoundedRectangle(cornerRadius: 25,style: .continuous)
                            .fill(Color(white:0.99))
                        RoundedRectangle(cornerRadius: 25,style: .continuous)
                            .strokeBorder(
                                userColor,
                                lineWidth: isFocused ? 4 : 2
                            )
                    }
                }
            }.frame(height: 80)
            
            ScrollView(.vertical,showsIndicators: true){
                VStack{
                    
                    datePickerView(date: $dateStart,title: "Start")
                    
                    Divider().format()
                    
                    datePickerView(date: $dateEnd ,title: "End")
                    
                    Divider().format()
                    
                    HStack{
                        DisclosureGroup{
                            CustomColorPickerView(selectedColor: $taskColor)
                        } label: {
                            HStack{
                                Text("Color").font(.title2.bold()).foregroundColor(.black)
                                Spacer()
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                                    .foregroundColor(taskColor)
                                    .frame(width: 40).offset(x:-5)
                            }
                        }
                    }
                    
                    Divider().format()
                    
                    HStack{
                        Text("Icon").font(.title2.weight(.bold))
                        Spacer()
                        ZStack{
                            Circle().fill(taskColor).frame(width: 40)
                            Rectangle().fill(.white).mask{
                                Image(systemName:icon   )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }.frame(width: 25.0, height: 25.0)
                        }.frame(width: 40).offset(x:-23.5)
                    }
                    
                    
                    
                    Divider().format()
                    
                    HStack{ Text("Notes").font(.title2.weight(.bold)); Spacer()}
                    TextEditor(text: $fullText)
                        .scrollContentBackground(.hidden)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.yellow)
                        )
                        .frame(minHeight: 175,maxHeight: 250)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    
                    
                } // End of ScrollView
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 20,style: .continuous)
                        .fill(.white, strokeBorder: userColor)
                )
            }
            .frame(minWidth:100, maxWidth: .infinity)
            Spacer()
        }
        .padding(10)
        .ignoresSafeArea(edges:.bottom)
        .background(
            Color(white : 0.95)
        )
    }
    private func addObject(){
        item.title = taskName
        item.icon = icon
        item.dateStart = dateStart
        item.dateEnd = dateEnd
        item.color = taskColor.toDouble()
        item.duration = dateEnd.timeIntervalSince(dateStart) / 3600
        item.completed = false
        item.id = UUID()
        item.info = fullText
        item.taskDay = extractDate(date: dateStart, format: "MM-dd-yyyy")
    }
    private func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        return formatter.string(from:date)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView( item: .init(entity: Tasks.entity(), insertInto: PersistenceController.preview.container.viewContext))
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

extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: Double = 2) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(
                self.fill(fillStyle)
            )
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



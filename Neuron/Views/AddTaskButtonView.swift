//
//  HeaderButtonsView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/27/22.
//

import SwiftUI

struct AddTaskButtonView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var configuration: AddTaskConfig<Tasks>?

    var body: some View {
        HStack{
            Button{
                addTask()
            }label: {
                Label{Text("Add Task")} icon: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(Color(red: 0.9, green: 0.6039,  blue:0.6039))
                }
            }
            .labelStyle(.iconOnly)
            .sheet(item: $configuration, onDismiss: cleanContext) {config in
                AddMainView(item: config.task)
                    .environment(\.managedObjectContext,config.childContext)
            }
        }.frame(width:60,height:60)
    }
    
    func addTask() {
        configuration = AddTaskConfig(withParentContext: viewContext)
    }
    func cleanContext(){
        try? viewContext.save()
    }
}

struct AddTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButtonView()
    }
}

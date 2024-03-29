//
//  HeaderButtonsView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/27/22.
//

import SwiftUI
import Foundation
import CoreData

struct AddTaskConfig: Identifiable {
    let id = UUID()
    let childContext: NSManagedObjectContext
    
    init(withParentContext viewContext: NSManagedObjectContext) {
        childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = viewContext
    }
}



struct AddTaskButtonView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var configuration: AddTaskConfig?

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
            .sheet(item: $configuration,onDismiss: cleanContext) {config in
                AddMainView().environment(\.managedObjectContext,config.childContext)
            }
        }.frame(width:60,height:60)
    }
    
    func addTask() {
        configuration = AddTaskConfig(withParentContext: viewContext)
    }
    func cleanContext(){
        try? viewContext.save()
        configuration = nil
    }
}

struct AddTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButtonView()
    }
}

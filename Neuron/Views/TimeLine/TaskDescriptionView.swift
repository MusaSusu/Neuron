//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/13/22.
//

import SwiftUI
import CoreData

struct TaskDescriptionView<T: NSManagedObject & isTimelineItem,Content:View> : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var task: T
    
    let content : () -> Content
    
    let capsuleHeight: Double
    
    var setColor: Color{
        return task.color?.fromDouble() ?? Color.red
    }
    var interval: String {
        (task.duration).toHourMin(from:.seconds )
    }
    
    init(task: T , capsuleHeight: Double,@ViewBuilder content: @escaping () -> Content) {
        self.task = task
        self.capsuleHeight = capsuleHeight
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            content()
            HStack{
                Text(task.notes ?? "")
            }
            
        }.padding(10)
        .frame(height: (capsuleHeight), alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(setColor).opacity(0.2) //white: 0.995
                .shadow(radius: 5)
        )
    }
}

struct TaskDescription_Previews: PreviewProvider {
    static var previews: some View {
        TaskDescriptionView<Tasks,EmptyView>(task: previewscontainer,capsuleHeight: 120,content: {EmptyView()})
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

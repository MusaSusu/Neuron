//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/13/22.
//

import SwiftUI
import CoreData

struct DescriptionView<T: NSManagedObject & isTimelineItem,Content:View> : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var task: T
    
    let content : () -> Content
    
    let capsuleHeight: Double
    
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
        }
        .padding(10)
        .frame(height: capsuleHeight, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(task.getColor()).opacity(0.2) //white: 0.995
                .shadow(radius: 5)
        )
    }
}

struct Description_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView<Tasks,EmptyView>(task: previewsTasks,capsuleHeight: 120,content: {EmptyView()})
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/13/22.
//

import SwiftUI

struct TaskDescriptionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var task: Time
    
    var setColor: Color{
        return task.color?.fromDouble() ?? Color.red
    }
    
    let capsuleHeight: Double
        
    var interval: String {
        (task.duration).toHourMin(from:.seconds )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            TimeLineTitleView(task: task)
            
            HStack{
                Text("\(task.notes ?? "nothing...")")
            }
            
        }
        .frame(height: (capsuleHeight), alignment: .topLeading)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(setColor).opacity(0.2) //white: 0.995
                .shadow(radius: 5)
        )
    }
}


struct strikethroughs: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: (rect.minX-5), y: (rect.midY)  ))
        path.addLine(to: CGPoint(x:(rect.maxX+5), y: (rect.midY) ))
        
        return path
    }
}

struct TaskDescription_Previews: PreviewProvider {
    static var previews: some View {
        TaskDescriptionView(task: previewscontainer,capsuleHeight: 120)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

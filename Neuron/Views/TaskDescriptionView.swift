//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/13/22.
//

import SwiftUI

struct TaskDescriptionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var task: Tasks
    
    let duration: Double
    let setColor: Color
        
    var interval: String {
        createDateString(duration:task.duration)
    }
    
    var body: some View {
        HStack(alignment:.center,spacing:0){
            
            HStack(spacing:0) {
                Text("\(task.title!)")
                    .font(.system(.title3,design: .default,weight:.semibold))
                    
                Text("  (\(interval))")
                    .italic()
                    .font(.system(.subheadline,weight: .light))
            }
            .overlay(
                strikethroughs()
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .fill(task.completed ? .red : .clear)
                )
            
            Spacer()
            
            Button {
                task.completed.toggle()
            } label: {
                Label {Text("Task Complete")} icon: {
                    Image(systemName: task.completed ? "circle.inset.filled" : "circle")
                        .foregroundColor(task.completed ? setColor.opacity(1) : .secondary)
                        .accessibility(label: Text(task.completed ? "Checked" : "Unchecked"))
                        .imageScale(.large)
                }
            }.labelStyle(.iconOnly)
                .buttonStyle(PlainButtonStyle())
        }
    }
}
    

private struct strikethroughs: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: (rect.minX-5), y: (rect.midY)  ))
        path.addLine(to: CGPoint(x:(rect.maxX+5), y: (rect.midY) ))
        
        return path
    }
}

private func createDateString(duration:TimeInterval)-> String{
    let df = DateComponentsFormatter()
    var interval: TimeInterval{(duration * 3600)}
    df.allowedUnits = [.hour,.minute]
    df.unitsStyle = .short
    return df.string(from: interval)!
}

struct TaskDescription_Previews: PreviewProvider {
    static var previews: some View {
        TaskDescriptionView(task: previewscontainer, duration: 0.5, setColor: .orange)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

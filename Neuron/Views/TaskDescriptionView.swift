//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/13/22.
//

import SwiftUI

struct TaskDescriptionView: View {
    @State var checker: Bool = false
    let taskTitle: String
    let duration: Double
    let setColor: Color
        
    var interval: String {
        "200"
    }
    
    
    var body: some View {
        HStack(alignment:.center,spacing:0){
            
            HStack(spacing:0) {
                Text("\(taskTitle)")
                    .font(.system(.title3,design: .default,weight:.semibold))
                Text("  (\(interval))")
                    .italic()
                    .font(.system(.subheadline,weight: .light))
            }.overlay(
                strikethroughs()
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .fill(checker ? .red : .clear)
                )
            
            Spacer()
            
            Button {
                checker.toggle()
            } label: {
                Label {Text("Task Complete")} icon: {
                    Image(systemName: checker ? "circle.inset.filled" : "circle")
                        .foregroundColor(checker ? setColor.opacity(1) : .secondary)
                        .accessibility(label: Text(checker ? "Checked" : "Unchecked"))
                        .imageScale(.large)
                }
            }.labelStyle(.iconOnly)
                .buttonStyle(PlainButtonStyle())
        }
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
        TaskDescriptionView(taskTitle: "Title", duration: 0.5, setColor: .orange)
    }
}

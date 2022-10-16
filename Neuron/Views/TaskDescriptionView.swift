//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/13/22.
//

import SwiftUI

struct TaskDescriptionView: View {
    let taskid: String
    let taskTitle: String
    let duration: Double
    let setColor: Color
    @EnvironmentObject var data: DataSource
    
    @State private var buttonState: Bool = false
    
    var interval: String {
        let df = DateComponentsFormatter()
        var interval: TimeInterval{(duration * 3600)}
        df.allowedUnits = [.hour,.minute]
        df.unitsStyle = .short
        return df.string(from: interval)!
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
                    .fill(data.taskData[taskid]!.taskChecker ? .red : .clear)
                )
            Spacer()
                Button {
                    data.taskData[taskid]!.taskChecker.toggle()
            } label: {
                Label {Text("Task Complete")} icon: {
                    Image(systemName: data.taskData[taskid]!.taskChecker ? "circle.inset.filled" : "circle")
                        .foregroundColor(data.taskData[taskid]!.taskChecker ? setColor.opacity(1) : .secondary)
                        .accessibility(label: Text(data.taskData[taskid]!.taskChecker ? "Checked" : "Unchecked"))
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
        TaskDescriptionView(taskid: "1",taskTitle: "Title", duration: 0.5, setColor: .orange).environmentObject(DataSource())
    }
}

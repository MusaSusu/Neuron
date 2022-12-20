//
//  TimeLineTitleView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/20/22.
//

import SwiftUI

struct TimeLineTitleView: View {
    @ObservedObject var task : Tasks
    var body: some View {
        HStack(alignment:.center,spacing:0){
            
            HStack(spacing:0) {
                Text("\(task.title!)")
                    .font(.system(.title3,design: .default,weight:.semibold))
                
                Text("  (\( task.date.duration.toHourMin(from: .seconds) ))")
                    .italic()
                    .font(.system(.subheadline,weight: .light))
            }
            .overlay(
                strikethroughs()
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .fill(task.taskChecker ? .red : .clear)
            )
            
            Spacer()
            
            Button {
                task.taskChecker.toggle()
            } label: {
                Label {Text("Task Complete")} icon: {
                    Image(systemName: task.taskChecker ? "circle.inset.filled" : "circle")
                        .foregroundColor(task.taskChecker ? task.color?.fromDouble().opacity(1) : .secondary)
                        .accessibility(label: Text(task.taskChecker ? "Checked" : "Unchecked"))
                        .imageScale(.large)
                }
            }.labelStyle(.iconOnly)
        }
    }
}

struct TimeLineTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineTitleView(task: previewscontainer)
    }
}

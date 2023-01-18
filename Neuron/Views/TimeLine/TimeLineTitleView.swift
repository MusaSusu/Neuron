//
//  TimeLineTitleView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/20/22.
//

import SwiftUI
import CoreData

struct TimeLineTitleView<T:NSManagedObject & isTimelineItem, Content:View>: View {
    @ObservedObject var task : T
    let content : () -> Content
    
    init(task:T,@ViewBuilder content: @escaping () -> Content){
        self.task = task
        self.content = content
    }
    
    var body: some View {
        HStack(alignment:.center,spacing:0){
            
            HStack(spacing:0) {
                Text("\(task.title!)")
                    .font(.system(.title3,design: .default,weight:.semibold))
                
                Text("  (\( task.dateInterval.duration.toHourMin(from: .seconds) ))")
                    .italic()
                    .font(.system(.subheadline,weight: .light))
            }
            .overlay(
                strikethroughs()
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .fill(task.taskChecker ? .red : .clear)
            )
            
            Spacer()
            content()
        }
    }
}

struct TimeLineTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineTitleView<Tasks,EmptyView>(task: previewscontainer,content: {EmptyView()})
    }
}

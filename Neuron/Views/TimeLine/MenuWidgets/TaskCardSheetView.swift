//
//  TaskCardSheetView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/31/23.
//

import SwiftUI

struct TaskCardSheetView<T: isTimelineItem>: View {
    @ObservedObject var Task : T
    var body: some View {
        Text("Hello, World!")
    }
}

struct TaskCardSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardSheetView<Tasks>(Task: previewsTasks)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

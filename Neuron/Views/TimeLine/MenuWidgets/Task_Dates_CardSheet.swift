//
//  Task_Dates_CardSheet.swift
//  Neuron
//
//  Created by Alvin Wu on 2/1/23.
//

import SwiftUI

struct Task_Dates_CardSheet: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var Task : Tasks
    
    var taskDates : [Date] {
        Task.getAllDates()
    }
    
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
    
    var body: some View {
        VStack{
            ForEach(taskDates.indices, id:\.self) { index in
                HStack{
                    Spacer()
                    Text(taskDates[index].formatted(date: .long, time: .shortened))
                        .padding(10)
                    Spacer()
                }
                .backgroundStrokeBorder(opacity: 0.99, lineWidth: 1)
            }
        }
        .backgroundStrokeBorder(opacity: 0.9, lineWidth: 0)
    }
}

struct Task_Dates_CardSheet_Previews: PreviewProvider {
    static var previews: some View {
        Task_Dates_CardSheet(Task: previewsTasks)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

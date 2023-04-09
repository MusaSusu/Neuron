//
//  Task_Dates_CardSheet.swift
//  Neuron
//
//  Created by Alvin Wu on 2/1/23.
//

import SwiftUI

struct DateCard_Task_View: View {
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
                    Spacer()
                }
                .padding(10)

            }
        }
        .background(.white.opacity(1))
        .cornerRadius(20)

    }
}

struct Task_Dates_CardSheet_Previews: PreviewProvider {
    static var previews: some View {
        DateCard_Task_View(Task: previewsTasks)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

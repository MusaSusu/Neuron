//
//  TimeFramePicker.swift
//  Neuron
//
//  Created by Alvin Wu on 11/28/22.
//

import SwiftUI

struct SubTaskAdder: View {
    @EnvironmentObject var SubTasks : SubTaskModel
    @State var showSheet : Bool = false
    @State var selectedSubTask : SubTask?
    
    var body: some View {
        VStack{
            
            Group{
                if SubTasks.subTaskCollection.count == 0{
                    Text("No subtasks saved")
                        .foregroundColor(.gray)
                }
                List(
                    $SubTasks.subTaskCollection,
                    editActions: [.delete,.move],
                    selection: $selectedSubTask
                ){ $item in
                    DisclosureGroup{
                        HStack{
                            Text(item.notes)
                        }.deleteDisabled(true)
                    } label:{
                        Text(item.title)
                    }
                }
                .scrollContentBackground(.hidden)
                .listRowSeparatorTint(userColor.opacity(1))
                .listStyle(.insetGrouped)
                .scaledToFit()
            }
            
            HStack{
                Spacer()
                Button{
                    showSheet = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.red)
                        .imageScale(.large)
                }
            }.sheet(isPresented: $showSheet){
                SubTaskView()
                    .presentationDetents([.large])
            }
        }
    }
}

struct SubTaskAdder_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskAdder().environmentObject(SubTaskModel())
    }
}

private extension RoundedRectangle{
    func formatBackground() -> some View{
        self
            .fill(Color(white: 0.95))
            .padding(-5)
    }
}


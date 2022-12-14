//
//  TimeFramePicker.swift
//  Neuron
//
//  Created by Alvin Wu on 11/28/22.
//

import SwiftUI

struct SubTaskAdderDisc: View {
    var body: some View {
        HStack{
            DisclosureGroup(content: {SubTaskAdderView()},
                            label: {Text("SubTasks").titleFont() }
            )
        }
    }
}

struct SubTaskAdderView: View {
    @EnvironmentObject var Project : ProjectModel
    @State var showSheet : Bool = false
    @State var selectedSubTask : SubTask?
    
    var body: some View {
        VStack{
            
            Group{
                if Project.subTaskCollection.count == 0{
                    Text("No subtasks saved")
                        .foregroundColor(.gray)
                }
                List(
                    $Project.subTaskCollection,
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
                SubTaskSheetView()
                    .presentationDetents([.large])
            }
        }
    }
}

struct SubTaskAdderDisc_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskAdderDisc().environmentObject(ProjectModel())
    }
}

private extension RoundedRectangle{
    func formatBackground() -> some View{
        self
            .fill(Color(white: 0.95))
            .padding(-5)
    }
}

/*
 Button {
 item.completed.toggle()
 } label: {
 Label {Text("Task Complete")} icon: {
 Image(systemName: item.completed ? "circle.inset.filled" : "circle")
 .foregroundColor(item.completed ? .gray : .red)
 .accessibility(label: Text(item.completed ? "Checked" : "Unchecked"))
 .imageScale(.large)
 }
 }.labelStyle(.iconOnly)
 */

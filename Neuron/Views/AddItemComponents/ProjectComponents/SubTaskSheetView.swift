//
//  SubTaskView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/28/22.
//

import SwiftUI

struct SubTaskSheetView: View {
    @EnvironmentObject var Project : ProjectModel
    @State var item : SubTask = SubTask(title: "", notes: "")
    @State private var isFocused: Bool = true
    @Environment(\.dismiss) var dismiss
    func saveItem(){
        if item.title.trimmingCharacters(in: .whitespacesAndNewlines).count == 0{
            item.title = "Subtask"
        }
        Project.subTaskCollection.append(item)
        dismiss()
    }
    var body: some View {
        VStack{
            
            HStack{
                Button("Cancel",action:{dismiss()})
                    .padding(.leading,10)
                    .font(.title3)
                Spacer()
                Button("Save",action: {saveItem()})
                    .padding(.trailing,10)
                    .font(.title3)
            }.padding(.top,15)
            
            VStack{
                HStack{
                    TextField("Title", text: $item.title)
                        .foregroundColor(.black)
                        .font(.title.weight(.semibold))
                        .padding(.vertical,5)
                        .padding(.horizontal, 10)
                        .autocorrectionDisabled()
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                    
                }
                Divider().format()
                HStack{
                    VStack{
                        HStack{
                            Text("Notes").titleFont()
                            Spacer()
                        }
                        
                        TextEditor(text: $item.notes)
                            .scrollContentBackground(.hidden)
                            .keyboardType(.default)
                            .frame(minHeight: 175,maxHeight: 250)
                            .padding(5)
                            .font(.title3)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.yellow)
                            )
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        
                    }
                }
            }
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 20, trailing: 15))
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white, strokeBorder: userColor)
                }
            Spacer()
        }
        .padding(.horizontal,10)
        .ignoresSafeArea(.container)
        .background(
            Color(white: 0.95)
        )


    }
}

struct SubTaskSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskSheetView().environmentObject(ProjectModel())
    }
}

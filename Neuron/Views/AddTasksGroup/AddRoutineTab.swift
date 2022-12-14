//
//  AddRoutineView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/5/22.
//

import SwiftUI

struct AddRoutineTab: View {
    @EnvironmentObject var NewItem : NewItemModel
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing:10){
                //COLOR PICKER
                
                ColorPickerView(color: $NewItem.color)
                
                Divider().format()
                
                DurationPickerView()
                
                Divider().format()
                
                DisclosureGroup{
                    RoutineMakerView()
                } label: {
                    Text("Sub-Routine").titleFont()
                }
                
                Divider().format()
                
                HStack{
                    DisclosureGroup{
                        RoutineSchedDiscView().padding(.vertical)
                    } label: {
                        Text("Schedule").titleFont()
                    }
                }
                
                Divider().format()
                //NOTES
                NotesView()
            }
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 20, trailing: 15))
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white, strokeBorder: userColor)
                    .padding(.horizontal,1)
            )
        }.padding(.horizontal,5)
    }
}

struct AddRoutineTab_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineTab()
            .environmentObject(NewItemModel())
            .environmentObject(RoutineViewModel())
    }
}

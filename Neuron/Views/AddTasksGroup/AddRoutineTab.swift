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
            VStack{
                //COLOR PICKER
                
                ColorPickerView(color: $NewItem.color)
                
                Divider().format()
                
                HStack{
                    DisclosureGroup{
                        
                    }label:{
                        Text("Routine").titleFont()
                    }
                    //need better name. basically like parts of the routine.
                    Spacer()
                }
                
                Divider().format()
                
                HStack{
                    Text("Schedule").titleFont()
                    Spacer()
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
    }
}

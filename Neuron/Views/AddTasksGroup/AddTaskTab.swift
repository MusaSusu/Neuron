//
//  AddTabView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/8/22.
//

import SwiftUI

struct AddTaskTab: View {
    @EnvironmentObject var DateList : DateListModel
    @EnvironmentObject var NewItem : NewItemModel
            
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing:10){
                //COLOR PICKER
                ColorPickerView(color: $NewItem.color)
                
                Divider().format()
                
                //Duration
                
                DurationPickerView()
                
                Divider().format()
                
                //Dates
                Group{
                    DatePickerView().environmentObject(DateList)
                }
                
                Divider().format()
                
                //NOTES
                Group{
                    NotesView().environmentObject(NewItem)
                }
            } // End of ScrollView
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 20, trailing: 15))
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white, strokeBorder: userColor)
                    .padding(.horizontal,1)
            )
            
        }.padding(.horizontal,5)
    }
}

struct AddTaskTab_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskTab()
            .environmentObject(DateListModel())
            .environmentObject(NewItemModel())
    }
}

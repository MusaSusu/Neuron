//
//  AddProjectTab.swift
//  Neuron
//
//  Created by Alvin Wu on 11/21/22.
//

import SwiftUI

struct AddProjectTab: View {
    @EnvironmentObject var NewItem : NewItemModel
    
    @State var date : Date = Date()
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing:10){
                //COLOR PICKER
                ColorPickerView(color: $NewItem.color)
                
                Divider().format()
                
                ProjectEndDateDisc()
                
                Divider().format()
                HStack{
                    DisclosureGroup{
                        SubTaskAdder()
                    } label:{
                        Text("Sub-Tasks").titleFont()
                    }
                }
                
                
                Divider().format()
                //NOTES
                Group{
                    HStack{
                        Text("Schedule").titleFont()
                            //Button to auto assign tasks for completion?
                        Spacer()
                    }
                }
                
                Divider().format()
                //NOTES
                Group{
                    NotesView()
                }
                
             // End of ScrollView
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


struct AddProjectTab_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectTab()
            .environmentObject(NewItemModel())
            .environmentObject(ProjectModel())
    }
}

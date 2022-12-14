//
//  NotesView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/21/22.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject var NewItem : NewItemModel
    
    var body: some View {
        VStack{
            HStack{
                DisclosureGroup{
                    
                    TextEditor(text: $NewItem.notes)
                        .scrollContentBackground(.hidden)
                        .keyboardType(.default)
                        .frame(minHeight: 200,maxHeight: 250)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.yellow)
                        )
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))

                }label: {
                    Text("Notes").foregroundColor(.black).font(.title2.weight(.bold))
                }
            }
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView().environmentObject(NewItemModel())
    }
}

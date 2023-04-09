//
//  Notes_Card_View.swift
//  Neuron
//
//  Created by Alvin Wu on 2/5/23.
//

import SwiftUI

struct Notes_Card_View : View {
   @Binding var notesString : String?
    
    var body: some View {
        TextEditor(text: Binding($notesString)!)
            .scrollContentBackground(.hidden)
            .keyboardType(.default)
            .frame(minHeight: 200,maxHeight: 250)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.yellow)
            )
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))    }
}

struct Notes_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        Notes_Card_View(notesString: .init(get: {previewsTasks.notes},
                                           set: {newval in previewsTasks.notes = newval })
        )
    }
}

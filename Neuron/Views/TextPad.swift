//
//  TextPad.swift
//  Neuron
//
//  Created by Alvin Wu on 11/1/22.
//

import SwiftUI
import UIKit

struct TextPad: View {
    
    @State private var fullText: String = "test"
    
    init() {
        UITextView.appearance().backgroundColor = .clear // ios 15
    }
    var body: some View {
        HStack{
            TextEditor(text: $fullText)
                .scrollContentBackground(.hidden)// <- Hide it ios 16
                .background(.yellow).opacity(0.7)
                .frame(height:200)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct TextPad_Previews: PreviewProvider {
    static var previews: some View {
        TextPad()
    }
}

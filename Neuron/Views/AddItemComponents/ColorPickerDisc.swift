//
//  ColorPickerView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/13/22.
//

import SwiftUI

struct ColorPickerDisc: View {
    @Binding var color: Color
    var body: some View {
            HStack{
                DisclosureGroup{
                    CustomColorPickerView(selectedColor: $color)
                } label: {
                    HStack{
                        Text("Color").titleFont()
                        Spacer()
                        Image(systemName: "circle.fill")
                            .resizeFrame(width: 35, height: 35)
                            .foregroundColor(color)
                            .offset(x:-5)
                    }
                }
            }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerDisc(color: .constant(.blue))
    }
}

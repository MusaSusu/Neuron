//
//  css file.swift
//  Neuron
//
//  Created by Alvin Wu on 11/22/22.
//

import Foundation
import SwiftUI

extension TextField {
    func customStyle() -> some View {
        self
            .foregroundColor(.black)
            .font(.title2.weight(.regular))
            .padding(.vertical,10)
            .padding(.horizontal, 14)
    }
}

extension Divider{
    func format() -> some View {
        self
            .frame(height:1)
            .background(Color(red: 0.5, green: 0.6039,  blue:0.8039))
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: -14))
    }
}

extension Text{
    func titleFont() -> Self{
        self
            .font(.title2.bold()).foregroundColor(.black)
    }
}


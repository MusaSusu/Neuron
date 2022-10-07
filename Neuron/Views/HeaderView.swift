//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 9/27/22.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing:0){
            VStack{
                Text(Date().formatted(date:.abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                Text("Today")
                    .font(.largeTitle.bold())
            }.frame(maxWidth: .infinity,alignment:.leading)
                .print("header")
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}

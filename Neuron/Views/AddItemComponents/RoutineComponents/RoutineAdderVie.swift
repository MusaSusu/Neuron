//
//  RoutineAdderVie.swift
//  Neuron
//
//  Created by Alvin Wu on 12/6/22.
//

import SwiftUI

struct RoutineAddView: View {
    @State private var state: Bool = false
    
    var body: some View {
        VStack {
            Button("Animate") {
                withAnimation(.easeIn(duration: 1)) {
                    state.toggle()
                }
            }.buttonStyle(.bordered)
            HStack{
                if !state {
                            Rectangle()
                                .fill(.red)
                                .frame(width: state ? 90 : 100, height: 100)
                                .transition(.slide)
                        .transition(.slide)

                        VStack{
                            Rectangle()
                                .fill(.purple)
                                .frame(width: state ? 90 : 100, height: 100)
                                .transition(.scale)
                        }
                        .transition(.scale)
                }
                    else {
                        Rectangle()
                            .fill(.blue)
                            .frame(width: state ? 100 : 100, height: 100)
                            .transition(.slide)
                    }
            }.animation(.default, value: state)
        }
    }
}
struct RoutineAddView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineAddView()
    }
}

//
//  RoutineDurationSheet.swift
//  Neuron
//
//  Created by Alvin Wu on 12/10/22.
//

import SwiftUI

struct RoutineDurationSheet: View {
    @Binding var subRoutineDuration : Routine
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            HStack{
                Text("Duration").titleFont()
                Spacer()
                Text(subRoutineDuration.duration.toHourMin()).font(.title2)
                Spacer()
            }
            HStack{
                Slider(
                    value:$subRoutineDuration.duration,
                    in: 0...120,
                    step: 5
                )
            }.padding(.vertical,10)
            HStack{
                Spacer()
                Button(action: {dismiss()}) {
                    Text("Done")
                }
            }
        }.padding()
    }
}

struct RoutineDurationSheet_Previews: PreviewProvider {
    static var previews: some View {
        RoutineDurationSheet(subRoutineDuration: .constant(testRoutine))
    }
}

//
//  DurationPickerView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/5/22.
//

import SwiftUI

struct DurationPickerView: View {
    @EnvironmentObject var NewItem : NewItemModel
    
    var body: some View {
        Group{
            HStack{
                DisclosureGroup{
                    HStack{
                        Slider(
                            value:$NewItem.duration,
                            in: 0...120,
                            step: 5
                        )
                    }.padding(.top,10)
                    HStack{
                        Spacer()
                        Button("Custom Time") {
                            
                        }
                    }
                } label: {
                    HStack(spacing:0){
                        Text("Duration").titleFont()
                        Spacer()
                        Text("\(createDateString(duration:NewItem.duration))")
                            .titleFont()
                    }
                }
            }
        }
    }
}

struct DurationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DurationPickerView().environmentObject(NewItemModel())
    }
}

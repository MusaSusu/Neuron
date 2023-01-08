//
//  FrequencyPicker.swift
//  Neuron
//
//  Created by Alvin Wu on 12/14/22.
//

import SwiftUI

struct FrequencyPickerDisc : View {
    var body: some View{
        DisclosureGroup(
            content: {FrequencyPicker().padding(.vertical)},
            label: {
                HStack{
                    Text("Frequency").titleFont()
                    Spacer()
                }
            }
        )
    }
}

struct FrequencyPicker: View {
    @EnvironmentObject var Habit_Add : HabitModel_Add
    @State private var isEditing = false
    @State private var isSheet = false
    
    var body: some View {
        VStack{
            HStack{
                    Button(
                        action: {isSheet.toggle()},
                        label: {Text("\(Int(Habit_Add.selectedFreq))").font(.title2)}
                    )
                    .sheet(isPresented: $isSheet){
                        freqSlider()
                            .presentationDetents([.fraction(1/4)])
                    }
                Text(" times").titleFont()
                Picker("timeFrame", selection: $Habit_Add.timeFrame){
                    ForEach(timeFrame.allCases) { item in
                        Text(item.rawValue).font(.title2)
                    }
                }
            }
        }
    }
    func freqSlider() -> some View {
        Slider(value: $Habit_Add.selectedFreq,
               in: 0...10,
               step: 1,
               onEditingChanged: {editing in
            isEditing = editing
        })
    }
}


struct FrequencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        FrequencyPicker().environmentObject(HabitModel_Add())
    }
}

struct FrequencyPickerDisc_Previews: PreviewProvider {
    static var previews: some View {
        FrequencyPickerDisc()
    }
}

//
//  datePickerView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/1/22.
//

import SwiftUI

struct datePickerView: View {
    
    @Binding  var date : Date
    var title: String
    
    var body: some View {
        VStack{
            DatePicker(
                title,
                selection: $date,
                displayedComponents: [.date,.hourAndMinute]
            )
            .font(.title2.weight(.semibold))
            }
        }
    }

struct datePickerView_Previews: PreviewProvider {
    static var previews: some View {
        datePickerView(date: .constant(Date()),title: "Start")
    }
}

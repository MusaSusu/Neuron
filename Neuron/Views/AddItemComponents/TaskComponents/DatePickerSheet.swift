//
//  DatePickerModal.swift
//  Neuron
//
//  Created by Alvin Wu on 11/12/22.
//

import SwiftUI

struct DatePickerSheet: View {
    @EnvironmentObject var DateList : TaskModel_Add
    var dismiss: ()-> Void
    var body: some View {
        VStack{
            HStack{
                DatePicker(
                    "Add Date",
                    selection: $DateList.dates[DateList.currentEdit].date,
                    displayedComponents: [.date,.hourAndMinute]
                ).labelsHidden()
            }.padding()
            
            Button{
                dismiss()
            }label: {
                Text("Finished")
            }
        }
        .frame(maxWidth:.infinity, maxHeight:200)
        .background(Color(white:1))
        .cornerRadius(20)
        .padding(.horizontal)
        .shadow(radius: 5)
    }
}

struct DatePickerSheet_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerSheet(dismiss: {})
            .environmentObject(TaskModel_Add())
    }
}

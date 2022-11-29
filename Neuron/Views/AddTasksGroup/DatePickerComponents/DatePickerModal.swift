//
//  DatePickerModal.swift
//  Neuron
//
//  Created by Alvin Wu on 11/12/22.
//

import SwiftUI

struct DatePickerModal: View {
    @EnvironmentObject var DateList : DateListModel
    
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
                DateList.isPop.toggle()
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

struct DatePickerModal_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerModal().environmentObject(DateListModel())
    }
}

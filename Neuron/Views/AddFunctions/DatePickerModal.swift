//
//  DatePickerModal.swift
//  Neuron
//
//  Created by Alvin Wu on 11/12/22.
//

import SwiftUI

struct DatePickerModal: View {
    @EnvironmentObject var DateList : DateListModel
    @State var date: Date = Date()
    
    var body: some View {
            VStack{
                HStack{
                    DatePicker(
                        "Add Date",
                        selection: $date,
                        displayedComponents: [.date,.hourAndMinute]
                    ).labelsHidden()
                    
                    Button{
                        DateList.isPop.toggle()
                    }label: {
                        Text("hello")
                    }
                    
                }.frame(maxWidth:.infinity, maxHeight:150)
                    .background(Color(white:0.95)).cornerRadius(20)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(.ultraThickMaterial)

        
    }
}

struct DatePickerModal_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerModal().environmentObject(DateListModel())
    }
}

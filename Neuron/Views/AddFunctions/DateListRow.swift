//
//  DateListItem.swift
//  Neuron
//
//  Created by Alvin Wu on 11/10/22.
//

import SwiftUI

struct DateListRow: View {
    @EnvironmentObject var DateList : DateListModel
    @State var date : Date
    @Binding var isEdit : Bool
    let index: Int
    
    init(date: Date,isEdit: Binding<Bool>,index:Int){
        _date = State(initialValue: date)
        _isEdit = isEdit
        self.index = index
    }
    

    var body: some View {
        HStack{
            DatePicker(
                "Add Date",
                selection: $date,
                displayedComponents: [.date,.hourAndMinute]
            )
            .labelsHidden()
            .disabled(!isEdit)
            .onChange(of: date){newVal in
                DateList.updateDateQueue(index: index, NewDate: newVal)
            }
            Text("\(index)")
            Text("\(date.formatted())")

            Spacer()
        }
    }
}

struct DateListRow_Previews: PreviewProvider {
    static var previews: some View {
        DateListRow(date: Date(),isEdit: .constant(true),index: 0).environmentObject(DateListModel())
    }
}

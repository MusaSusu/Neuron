//
//  DateList.swift
//  Neuron
//
//  Created by Alvin Wu on 11/10/22.
//

import SwiftUI

struct DateListView: View {
    @StateObject var DateList = DateListModel()
    @State var editMode: Bool = true
    
    
    var body: some View {
        VStack{
            let temp = Array( DateList.dates.enumerated())
            ForEach(temp,id:\.element){ index,item in
                HStack{
                    DateListRow(date: item, isEdit: $editMode,index: index).environmentObject(DateList)
                }
            }
            HStack{
                Spacer()
                Button{
                    DateList.addDate()
                }label: {
                    Label{Text("Add Date")} icon: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.red)
                    }.labelStyle(.iconOnly)
                }
            }.padding(.top,5)
            Spacer() 
        }
        .disabled(!editMode)
    }
}

struct DateListView_Previews: PreviewProvider {
    static var previews: some View {
        DateListView()
    }
}

//
//  DateList.swift
//  Neuron
//
//  Created by Alvin Wu on 11/10/22.
//

import SwiftUI

struct DateListView: View {
    @EnvironmentObject var DateList : DateListModel
    @State var isEditOn: Bool = false
                                                     
    var body: some View {
            VStack(spacing: 20){
                ForEach($DateList.dates,id:\.self.id){ item in
                    DateListRow(date: item,index: item.id).environmentObject(DateList)
                        .background{
                            RoundedRectangle(cornerRadius: 10,style: .circular)
                                .fill(DateList.isEditOn ? Color(white: 0.925) : .clear)
                                .padding(-5)
                        }
                }
                
                HStack{
                    Spacer()
                    Button{
                        DateList.addDate()
                    } label: {
                        Label{Text("Add Date")} icon: {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(DateList.isEditOn ? .red : .clear)
                        }.labelStyle(.iconOnly)
                    }
                }
                .padding(.horizontal)
                .disabled(!DateList.isEditOn)
            }
            .padding(.top,10)
        }
}

struct DateListView_Previews: PreviewProvider {
    static var previews: some View {
        DateListView().environmentObject(DateListModel())
    }
}

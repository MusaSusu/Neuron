//
//  datePickerView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/1/22.
//

import SwiftUI

struct datePickerView: View {
    
    @Binding  var date : Date
    @Binding var addInbox : Bool
    @Binding var addDateCheck : Bool
    @State var datesTable : [Date] = [Date(),Date().advanced(by: 3600), Date().advanced(by: 7200)]

    var body: some View {
            HStack{
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Add Dates").font(.callout.bold())
                        Spacer()
                    }
                    HStack{
                        DateListView()
                    }

                    Spacer()
            }
                
                VStack{
                    HStack{
                        Text("Add to Inbox?").bold().foregroundColor(.black)
                    }
                    HStack{
                        Spacer()
                        Image(systemName: "tray")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fill)
                            .frame(width: 25,height: 25)
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            toggleCheck()
                        } label: {
                            Label {Text("Add to Inbox?")} icon: {
                                Image(systemName: addInbox ? "circle.inset.filled" : "circle")
                                    .foregroundColor(addInbox ? .red : .secondary)
                                    .accessibility(label: Text(addInbox ? "Checked" : "Unchecked"))
                                    .imageScale(.large)
                            }
                        }.labelStyle(.iconOnly)
                        Spacer()
                    }
                    Spacer()
                }
                
            }
    }
    private func toggleCheck(){
        if addDateCheck == false{
            return
        }
        else{
            addInbox.toggle()
        }
    }
}

struct datePickerView_Previews: PreviewProvider {
    static var previews: some View {
        datePickerView(date: .constant(Date()), addInbox: .constant(true),addDateCheck: .constant(true) )
    }
}

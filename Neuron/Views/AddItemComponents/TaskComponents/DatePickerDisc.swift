//
//  datePickerView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/1/22.
//

import SwiftUI

struct DatePickerDisc: View {
    @EnvironmentObject var DateList : TaskModel_Add
    
    var body: some View {
        HStack{
            DisclosureGroup{
                VStack{
                    
                    DateListView().environmentObject(DateList).frame(minWidth: 220)
                    
                    Divider().format()
                    
                    HStack{
                        HStack{
                            Text("Add to Storage?  ").bold().foregroundColor(.black)
                            Image(systemName: "tray")
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frame(width: 20,height: 20)
                                .foregroundColor(.black)
                            Button {
                                toggleCheck()
                            } label: {
                                Label {Text("Add to Inbox?")} icon: {
                                    Image(systemName: DateList.addInboxCheck ? "circle.inset.filled" : "circle")
                                        .foregroundColor(DateList.addInboxCheck ? .red : .secondary)
                                        .accessibility(label: Text(DateList.addInboxCheck ? "Checked" : "Unchecked"))
                                        .imageScale(.large)
                                }
                            }
                            .labelStyle(.iconOnly)
                            .padding(.horizontal,5)
                        }
                        Spacer()
                        HStack{
                            Toggle(isOn: $DateList.isEditOn){
                                HStack{
                                    Text(DateList.isEditOn ? "Done" : "Edit").fontWeight(.semibold)
                                }
                            }
                            .toggleStyle(.button)
                            .tint(DateList.isEditOn ? .red : .blue)
                            .foregroundColor(DateList.isEditOn ? .red : .blue)
                        }
                    }.padding(.horizontal)
                    
                }.padding(.top)
            } label:{
                HStack{
                    Text("Date").titleFont()
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fill)
                        .frame(width: 25,height: 25)
                        .foregroundColor(DateList.addDateCheck ? .black : Color(white: 0.5))
                    
                    Divider().frame(maxHeight: 30).padding(.horizontal)
                    
                    Image(systemName: "tray")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fill)
                        .frame(width: 25,height: 25)
                        .foregroundColor(DateList.addInboxCheck ? .black : .white)
                }.padding(.trailing,10)
            }
        }
    }
    
    private func toggleCheck(){
        if DateList.addDateCheck == false{
            return
        }
        else{
            DateList.addInboxCheck.toggle()
        }
    }
}

struct DatePickerDisc_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerDisc().environmentObject(TaskModel_Add())
    }
}

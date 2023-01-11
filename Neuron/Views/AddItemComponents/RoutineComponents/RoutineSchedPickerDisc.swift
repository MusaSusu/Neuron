//
//  RoutineScheduleDisclosureView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/11/22.
//

import SwiftUI

struct RoutineSchedPickerDisc: View {
    @EnvironmentObject var Routine : RoutineModel_Add
    
    
    var body: some View {
        HStack{
            DisclosureGroup{
                RoutineSchedPicker()
                    .padding(.vertical)
                } label: {
                    Text("Schedule").titleFont()
                }
            }
    }
}

struct RoutineSchedPicker : View {
    @EnvironmentObject var Routine : RoutineModel_Add
    @State var isSheet = true
    
    var body: some View{
        VStack{
            
            HStack{
                VStack{Text("")}.frame(width: 80)
                Divider().background(.black)
                ForEach($Routine.scheduleList, id: \.self){ $item in
                    Spacer()
                        VStack{
                            Text(item.name).bold()
                            }
                        .frame(width:15,height: 30)
                        .foregroundColor(.black)
                    Spacer()
                    Divider().background(.black)
                }
            }.frame(alignment: .leading)
            
            HStack{
                Text(Date().startOfDay().formatted(date: .omitted, time: .shortened))
                    .frame(width: 80,height:30,alignment: .leading)
                Divider().background(.black)
                
                ForEach($Routine.scheduleList, id: \.self){ $item in
                    Spacer()
                    VStack{
                        Button(action: {item.check.toggle()} ){
                            Image(systemName: item.check ? "circle.inset.filled" : "circle")
                                .foregroundColor(.red)
                        }
                    }
                    .frame(width:15,height: 30)
                    .foregroundColor(.black)
                    Spacer()
                    Divider().background(.black)
                }
                
            }.frame(alignment: .leading)
            
        }.padding(.horizontal,5)
    }
}

struct RoutineSchedPickerDisc_Previews: PreviewProvider {
    static var previews: some View {
        RoutineSchedPickerDisc().environmentObject(RoutineModel_Add())
    }
}

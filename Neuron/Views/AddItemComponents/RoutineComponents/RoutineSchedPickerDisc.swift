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
    @State var dateSelect = Date()
    let daysofweek = Calendar.current.veryShortStandaloneWeekdaySymbols
    
    var body: some View{
        VStack{
            
            HStack{
                VStack{Text("")}.frame(width: 80)
                Divider().background(.black)
                ForEach(daysofweek, id: \.self){ item in
                    Spacer()
                    VStack{
                        Text(item).bold()
                    }
                    .frame(width:15,height: 30)
                    .foregroundColor(.black)
                    Spacer()
                    Divider().background(.black)
                }
            }.frame(alignment: .leading)
            
            ForEach($Routine.scheduleList, id: \.self){ $item in
                HStack{
                    DatePicker(selection: $dateSelect,displayedComponents: [.hourAndMinute]){
                    }
                    .frame(width: 80,height:30)
                        .buttonBorderShape(.roundedRectangle(radius: 10))
                    Divider().background(.black)
                    
                    ForEach(item.weekdays.indices, id: \.self){ index in
                        Spacer()
                        VStack{
                            Button(action: {item.weekdays[index].toggle()} ){
                                Image(systemName: item.weekdays[index] ? "circle.inset.filled" : "circle")
                                    .foregroundColor(.red)
                            }
                        }
                        .frame(width:15,height: 30)
                        .foregroundColor(.black)
                        Spacer()
                        Divider().background(.black)
                    }
                }
            }.frame(alignment: .leading)
            HStack{
                Text(Routine.scheduleList[0].weekdaysCD.debugDescription)
            }
        }.padding(.trailing,5)
    }
}

struct RoutineSchedPickerDisc_Previews: PreviewProvider {
    static var previews: some View {
        RoutineSchedPickerDisc().environmentObject(RoutineModel_Add())
    }
}

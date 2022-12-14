//
//  RoutineScheduleDisclosureView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/11/22.
//

import SwiftUI

struct RoutineSchedPickerDisc: View {
    @EnvironmentObject var RoutineModel : RoutineViewModel
    
    
    var body: some View {
        HStack{
            DisclosureGroup{
                HStack{
                    Spacer()
                    ForEach($RoutineModel.scheduleList, id: \.self){ $item in
                        VStack{
                            Button(action: {item.check.toggle()}){
                                Text(item.id)
                                    .underline(item.check, color: .red)
                                    .bold(item.check)
                                
                            }
                        }
                        .foregroundColor(item.check ? .black : Color(white: 0.5))
                        .background(
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .aspectRatio(1.0, contentMode: .fill)
                                    .opacity(item.check ? 1 : 0.7)
                                    .shadow(radius: item.check ? 3 : 1)
                                    .frame(width: 40,height: 40)
                            }
                            
                        )
                        .frame(width:40)
                        Spacer()
                    }
                }.padding(.vertical)
            } label: {
                Text("Schedule").titleFont()
            }
        }
    }
}

struct RoutineSchedPickerDisc_Previews: PreviewProvider {
    static var previews: some View {
        RoutineSchedPickerDisc().environmentObject(RoutineViewModel())
    }
}

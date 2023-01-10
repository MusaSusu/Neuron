//
//  DayOfWeekView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/5/23.
//

import SwiftUI

struct Header_DayOfWeekView: View {
    
    @EnvironmentObject var UserOptions : OptionsModel
    
    let week : [Date]
    
    var body: some View {
            
            HStack(){
                Spacer()
                ForEach(week, id: \.self) { day in
                    
                    VStack(spacing:1){
                        
                        Text(UserOptions.extractDate(date:day, format: "EEE").prefix(3))
                            .font(.system(size:12))
                            .fontWeight(.semibold)
                        
                        Divider()
                            .frame(width:25,height: 3)
                            .overlay(UserOptions.isSelected(date: day) ? .red : Color(white: 0.9))
                        
                        Text(UserOptions.extractDate(date:day, format: "dd"))
                            .font(.system(size:20))
                            .fontWeight(.semibold)
                    }
                    .onTapGesture {
                        UserOptions.selectedDay = day
                        UserOptions.selectedDayString = UserOptions.extractDate(date:day, format: "MM-dd-yyyy")
                        
                    }
                    .foregroundColor(UserOptions.isSelected(date: day) ? .black : Color(white:0.7)  )
                    .background(
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .aspectRatio(1.0, contentMode: .fill)
                                .shadow(radius: UserOptions.isSelected(date: day) ? 6 : 2 )
                                .opacity(UserOptions.isSelected(date: day) ? 1 : 0.5)
                        }
                    )
                    Spacer()
                }
            }
    }
}

struct Header_DayOfWeekView_Previews: PreviewProvider {
    static var previews: some View {
        Header_DayOfWeekView(week: [])
            .environmentObject(OptionsModel())
    }
}

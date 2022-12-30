//
//  ContentView.swift
//  Neuron
//
//  Created by Alvin Wu on 9/25/22.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var UserOptions: OptionsModel
    
    var body: some View {
        VStack(spacing:0){
            HStack(){
                HeaderView().padding(.horizontal)
            }
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack(spacing:11){
                    
                    ForEach(UserOptions.currentWeek, id: \.self) { day in
                        
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
                }.padding()
            }
            
            // MARK: vertical time line view
            FullTimelineView( date: UserOptions.selectedDay.startOfDay())
            
            BottomTabView()
                .offset(y:-10)
            
        }.ignoresSafeArea(edges:.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(OptionsModel())
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

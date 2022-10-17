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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.dateStart, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Tasks>
    
    @StateObject var UserOptions: OptionsModel = OptionsModel()
    @EnvironmentObject var data: DataSource
    
    
    var body: some View {
        VStack(spacing:0){
            
            HeaderView().padding(.horizontal)
            
            // MARK: horizontal weekly scrollview (todo: attach a function that when you select date it attaches the corresponding taskview to the timeline vie
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack(spacing:11){
                    Spacer()
                    
                    ForEach(UserOptions.currentWeek, id: \.self) { day in
                        
                        VStack(spacing:1){
                            
                            Text(data.extractDate(date:day, format: "EEE").prefix(3))
                                .font(.system(size:12))
                                .fontWeight(.semibold)
                            
                            Divider()
                                .frame(width:25,height: 3)
                                .overlay(UserOptions.isSelected(date: day) ? .red : Color(white: 0.9))
                            
                            Text(data.extractDate(date:day, format: "dd"))
                                .font(.system(size:20))
                                .fontWeight(.semibold)
                        }
                        .onTapGesture {
                            UserOptions.selectedDay = day
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
            FullTimelineView( date: data.extractDate(date: UserOptions.selectedDay, format:"MM-dd-yyyy"))
            
            BottomTabView()
            
        }.ignoresSafeArea(edges:.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataSource())
        
        //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

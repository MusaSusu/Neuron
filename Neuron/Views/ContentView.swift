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
    @State private var selectedHeader = true
    var body: some View {
        VStack(spacing:0){
            
            HStack(){
                HeaderView().padding(.horizontal)
                Button{
                    selectedHeader.toggle()
                } label: {
                    Text("header")
                }
            }
            
            Group{
                if selectedHeader{
                    Header_DayOfWeekView()
                }
                else{
                    Header_HabitsView()
                }
            }.frame(height: 75)
            
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

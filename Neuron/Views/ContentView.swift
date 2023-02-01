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
            
            HStack(alignment: .lastTextBaseline){
                HeaderView().padding(.horizontal)
                
                Button{
                    selectedHeader = false
                } label: {
                    Image(systemName: "brain.head.profile")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 25,height: 25)
                        .foregroundColor(selectedHeader ? .gray : .red)
                }
                Divider().frame(height: 40)
                Button{
                    selectedHeader  = true
                } label: {
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 25,height: 25)
                        .foregroundColor(selectedHeader ? .red : .gray)
                }
                Spacer()
            }.padding(.trailing)
            
            Group{
                if selectedHeader{
                    Header_ScrollTabView()
                }
                else{
                    Header_HabitsView()
                }
            }.frame(height: 75)
                
            // Vertical time line view
            TimeLineBuilderView( date: UserOptions.selectedDay.startOfDay())
            
            
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

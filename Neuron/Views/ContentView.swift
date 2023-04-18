//
//  ContentView.swift
//  Neuron
//
//  Created by Alvin Wu on 9/25/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.editMode) var editMode
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
            VStack{
                TimeLineBuilderView( date: UserOptions.selectedDay.startOfDay())
                
                Group{
                    if editMode?.wrappedValue == .active {
                        HStack{
                            Button{
                                
                            } label: {
                                Text("Undo")
                                    .font(.title2)
                            }
                            Spacer()
                            Button{
                                editMode?.wrappedValue = .inactive
                            } label: {
                                Text("Done")
                                    .font(.title2)
                            }
                            .buttonBorderShape(.roundedRectangle)
                        }
                        .frame(maxWidth: .infinity, minHeight: 30, maxHeight:60)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15))
                    }
                    else{
                        BottomTabView()
                    }
                }
                .animation(.linear(duration: 0.2), value: editMode?.wrappedValue)
                .transition(.move(edge: .bottom))
            }
            .cornerRadius(15)
            .background(
                Color(white : 0.995)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            )
            
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

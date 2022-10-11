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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item> /* fetches from cloud*/
    
    @StateObject var UserOptions: OptionsModel = OptionsModel()
    @EnvironmentObject var data: DataSource
    
    
    var body: some View {
            VStack(spacing:0){
                HeaderView().padding(.horizontal)
                    .print("content")
                
                // MARK: horizontal weekly scrollview (todo: attach a function that when you select date it attaches the corresponding taskview to the timeline view
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing:11){
                        Spacer()
                        
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
                
                
                // Create an array that has the tasks for the date and then create the view so I know which date is first to extend the arrow with? 
                FullTimelineView( date: UserOptions.extractDate(date: UserOptions.selectedDay, format:"MM-dd-yyyy"))
                    .environmentObject(data)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(white : 0.995))
                            .shadow(radius: 5)
                    )
                
                BottomTabView()
            }.ignoresSafeArea(edges:.bottom)
        }
    
    
    
    

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DataSource())
    }
}

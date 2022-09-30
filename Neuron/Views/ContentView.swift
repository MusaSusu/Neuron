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
    
    @StateObject var taskStorage: TaskViewModel = TaskViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                HeaderView().padding(.horizontal)
                
                // MARK: horizontal weekly scrollview
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing:11){
                        Spacer()
                        
                        ForEach(taskStorage.currentWeek, id: \.self) { day in
                            
                            VStack(spacing:1){
                                
                                Text(taskStorage.extractDate(date:day, format: "EEE").prefix(3))
                                    .font(.system(size:12))
                                    .fontWeight(.semibold)
                                
                                Divider()
                                    .frame(width:.infinity,height: 2)
                                    .overlay(taskStorage.isToday(date: day) ? .red : Color(white: 0.9))
                                
                                Text(taskStorage.extractDate(date:day, format: "dd"))
                                    .font(.system(size:20))
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(taskStorage.isToday(date: day) ? .black : Color(white:0.6)  )
                            .background(
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .aspectRatio(1.0, contentMode: .fill)
                                        .shadow(radius: taskStorage.isToday(date: day) ? 6 : 2 )
                                        .opacity(taskStorage.isToday(date: day) ? 1 : 0.5)
                                }
                            )
                            
                            Spacer()
                            
                        }
                    }.padding()
                }
                
                // MARK: vertical time line view
                
                ScrollView(.vertical,showsIndicators: false){
                    ForEach(1..<100){ i in
                        Text("i is \(i)")
                    }
                }

            }
            BottomTabView()
        }
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
    }
}

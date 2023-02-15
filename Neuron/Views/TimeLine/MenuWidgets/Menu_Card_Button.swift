//
//  Menu_TaskCard_View.swift
//  Neuron
//
//  Created by Alvin Wu on 1/31/23.
//

import SwiftUI
import CoreData

struct Menu_Card_Button<T: NSManagedObject & isTimelineItem>: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var Item : T
    @State var menuSelection : CardItems
    var menuItems : [ CardItems]
    
    
    @State var isSheet : Bool = false
    
    var body: some View {
        Button{
            showSheet()
        }label: {
            Image(systemName: "doc.text.image")
                .resizeFrame(width: 30, height: 30)
        }
        .foregroundStyle(Item.color?.fromDouble() ?? .red)
        .sheet(isPresented: $isSheet){
            TaskCardSheetView(Item: Item,
                              selection: menuSelection,
                              menuItems: menuItems)
            .presentationDetents([.medium,.large])
        }

        
    }
    
    func showSheet(){
        isSheet.toggle()
    }
}

struct Menu_Card_Button_Previews: PreviewProvider {
    static var previews: some View {
        Menu_Card_Button<Tasks>(Item: previewsTasks,menuSelection: .Notes,menuItems: [.Notes,.DateCard(.Task)])
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

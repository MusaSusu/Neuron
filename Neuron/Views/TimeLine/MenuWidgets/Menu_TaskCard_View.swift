//
//  Menu_TaskCard_View.swift
//  Neuron
//
//  Created by Alvin Wu on 1/31/23.
//

import SwiftUI
import CoreData

struct Menu_TaskCard_View<T: NSManagedObject & isTimelineItem>: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var Task : T
    @State var isSheet : Bool = false
    
    var body: some View {
        Button{
            showSheet()
        }label: {
            Image(systemName: "doc.text.image")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 30,height: 30)
        }
        .foregroundStyle(Task.color?.fromDouble() ?? .red)
        .sheet(isPresented: $isSheet){
            Text("HELLO")
        }
    }
    
    func showSheet(){
        isSheet.toggle()
    }
}

struct Menu_TaskCard_View_Previews: PreviewProvider {
    static var previews: some View {
        Menu_TaskCard_View<Tasks>(Task: previewsTasks)
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

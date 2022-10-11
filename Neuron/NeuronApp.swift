//
//  NeuronApp.swift
//  Neuron
//
//  Created by Alvin Wu on 9/25/22.
//

import SwiftUI

@main
struct NeuronApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var Data = DataSource()


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(Data)
        }
    }
}

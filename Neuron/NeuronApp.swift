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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  NeuronApp.swift
//  Neuron
//
//  Created by Alvin Wu on 9/25/22.
//

import SwiftUI

@propertyWrapper struct UserDefaultsBacked<Value> {
    let key: UserDefaultsKeys
    var storage: UserDefaults = .standard
    
    var wrappedValue: Value? {
        get { storage.value(forKey: key.rawValue) as? Value }
        set { storage.setValue(newValue, forKey: key.rawValue) }
    }
}

enum UserDefaultsKeys: String{
    case userColor
}

@main
struct NeuronApp: App {
    
    let persistenceController = PersistenceController.shared
    @StateObject private var UserOptions = OptionsModel()
    @Environment(\.scenePhase) private var phase
    
    init() {
        #if targetEnvironment(simulator)
        UserDefaults.standard.register(defaults: [
            UserDefaultsKeys.userColor.rawValue : testUserColor.toDouble()
        ]
        )
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(UserOptions)
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .active:
                guard let lastOpened = UserDefaults.standard.object(forKey: "LastOpened") as? Date else {
                    return
                }
                print("app acctive")
                let elapsed = Calendar.current.dateComponents([.day], from: lastOpened, to: Date()).day ?? 0
                print((UserDefaults.standard.object(forKey: "LastOpened") as? Date)?.formatted(.dateTime) ?? "")
                if elapsed >= 14 {
                    // show alert
                }
            case .inactive:
                UserDefaults.standard.set(Date(), forKey: "LastOpened")
                print("inactive")
                print((UserDefaults.standard.object(forKey: "LastOpened") as? Date)?.formatted(.dateTime) ?? "")
            case .background:
                print("background")
            @unknown default:
                print("default")
            }
        }
    }
}

//
//  AddTaskModel.swift
//  Neuron
//
//  Created by Alvin Wu on 10/27/22.
//

import Foundation
import CoreData

struct AddTaskConfig: Identifiable {
    let id = UUID()
    let context: NSManagedObjectContext
    let task: Tasks
        
    init(viewContext: NSManagedObjectContext, objectID: NSManagedObjectID) {
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = viewContext
        task = context.object(with: objectID) as! Tasks
    }
}


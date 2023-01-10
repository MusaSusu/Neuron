//
//  AddTaskModel.swift
//  Neuron
//
//  Created by Alvin Wu on 10/27/22.
//

import Foundation
import CoreData

struct AddTaskConfig<Tasks: NSManagedObject>: Identifiable {
    let id = UUID()
    let childContext: NSManagedObjectContext
        
    init(withParentContext viewContext: NSManagedObjectContext) {
        childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = viewContext
    }
}


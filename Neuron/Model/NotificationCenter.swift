//
//  NotificationCenter.swift
//  Neuron
//
//  Created by Alvin Wu on 1/19/23.
//

import Foundation
import CoreData

class ViewController: ObservableObject {
    
    var managedObjectContext: NSManagedObjectContext?
    var notificationcenter : NotificationCenter = NotificationCenter.default
    let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
    let testnotification  = Notification(name: .init("test"))
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(didSave(_:)),
                                               name: didSaveNotification, object: nil)
        
    }
    
    @objc func didSave(_ notification: Notification) {
        // handle the save notification
        let inserted: Set<NSManagedObject>? = notification.userInfo?.value(for: .insertedObjects)
        print(inserted as Any)
    }
}

extension Dictionary where Key == AnyHashable {
    func value<T>(for key: NSManagedObjectContext.NotificationKey) -> T? {
        return self[key.rawValue] as? T
    }
}

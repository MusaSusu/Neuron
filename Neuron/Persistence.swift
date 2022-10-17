//
//  Persistence.swift
//  Neuron
//
//  Created by Alvin Wu on 9/25/22.
//

import CoreData
import SwiftUI

let temp = [
    Task1(taskTitle: "Wake up", taskDescription: "Wakey time 10-08",taskIcon: "sun.max.fill", taskDateStart: "10-16-2022 01:00",taskDateEnd:"10-16-2022 01:30",taskDuration: 0.5, taskColor:[0.949,  0.522,  0], taskChecker: false),
    Task1(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  "10-16-2022 02:00",taskDateEnd: "10-16-2022 03:00",taskDuration: 1,taskColor:[0.9098, 0.6039,  0.6039], taskChecker: false),
    Task1(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: "10-16-2022 12:20",taskDateEnd:"10-16-2022 13:20",taskDuration: 1,taskColor: [0.32, 0.62,  0.81],taskChecker: false),
    Task1(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: "10-16-2022 13:20",taskDateEnd: "10-16-2022 13:50",taskDuration: 0.5,taskColor: [0.467,  0.867, 0.467],taskChecker: false),
    Task1(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop.fill", taskDateStart: "10-16-2022 14:50",taskDateEnd: "10-16-2022 15:50",taskDuration: 1, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false),
    Task1(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt.fill", taskDateStart: "10-16-2022 23:00",taskDateEnd: "10-16-2022 23:20",taskDuration: 0.33, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false),
    Task1(taskTitle: "Sleep", taskDescription: "Sleepytime",taskIcon: "moon.fill", taskDateStart:"10-16-2022 23:20",taskDateEnd: "10-16-2022 23:50",taskDuration: 0.5, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false)
]


struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<7 {
            let newItem = Tasks(context: viewContext)
            newItem.title = temp[i].taskTitle
            newItem.dateStart = convertDate(data: temp[i].taskDateStart)
            newItem.dateEnd = convertDate(data: temp[i].taskDateEnd)
            newItem.info = temp[i].taskDescription
            newItem.icon = temp[i].taskIcon
            newItem.duration = Float(temp[i].taskDuration)
            newItem.color = temp[i].taskColor
            newItem.completed = false
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Neuron")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

private func convertDate(data: String) -> Date{
    let formatter4 = DateFormatter()
    formatter4.dateFormat = "MM-dd-yyyy HH:mm"
    return formatter4.date(from: data) ?? Date.now
}

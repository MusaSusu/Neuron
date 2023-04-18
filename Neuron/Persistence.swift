//
//  Persistence.swift
//  Neuron
//
//  Created by Alvin Wu on 9/25/22.
//

import CoreData
import SwiftUI
import Foundation

#if targetEnvironment(simulator)
struct Task1: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskIcon: String
    var taskDateStart: Date
    var taskDateEnd: Date
    var taskDuration: CGFloat
    var taskColor: [Double]
    var taskChecker : Bool
}

let testUserColor = Color(red: 0.5, green: 0.6039,  blue:0.8039)
let hueColors = stride(from: 0, to: 1, by: 0.01).map {
    Color(hue: $0, saturation: 1, brightness: 1)
}

private let temp1 = [
    Task1(taskTitle: "Wake up", taskDescription: "Wakey time 10-08",taskIcon: "sun.max.fill", taskDateStart: convertDate(data: "12-21-2022 01:00"),taskDateEnd:convertDate(data: "12-21-2022 01:30"),taskDuration: 0.5, taskColor:[0.949,  0.522,  0.1], taskChecker: false),
    Task1(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  convertDate(data: "12-21-2022 02:00"),taskDateEnd: convertDate(data: "12-21-2022 03:00"),taskDuration: 1,taskColor:[0.9098, 0.6039,  0.6039], taskChecker: false),
    Task1(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: convertDate(data: "12-21-2022 12:20"),taskDateEnd:convertDate(data: "12-21-2022 13:20"),taskDuration: 1,taskColor: [0.32, 0.62,  0.81],taskChecker: false),
    Task1(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: convertDate(data: "12-21-2022 13:20"),taskDateEnd: convertDate(data: "12-21-2022 13:50"),taskDuration: 0.5,taskColor: [0.467,  0.867, 0.467],taskChecker: false),
    Task1(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop.fill", taskDateStart: convertDate(data: "12-21-2022 14:50"),taskDateEnd: convertDate(data: "12-21-2022 15:50"),taskDuration: 1, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false),
    Task1(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt.fill", taskDateStart: convertDate(data: "12-21-2022 23:00"),taskDateEnd: convertDate(data: "12-21-2022 23:20"),taskDuration: 0.33, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false),
    Task1(taskTitle: "Sleep", taskDescription: "Sleepytime",taskIcon: "moon.fill", taskDateStart:convertDate(data: "12-21-2022 23:20"),taskDateEnd: convertDate(data: "12-21-2022 23:50"),taskDuration: 0.5, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false)
]

private let temp = [
    Task1(taskTitle: "Wake up", taskDescription: "Wakey time 10-08",taskIcon: "sun.max.fill", taskDateStart: convertDate(data: "04-15-2023 01:00"),taskDateEnd:convertDate(data: "04-15-2023 01:30"),taskDuration: 0.5, taskColor:[0.949,  0.522,  0.1], taskChecker: false),
    Task1(taskTitle: "Do work", taskDescription: "math",taskIcon: "pencil", taskDateStart:  convertDate(data: "04-15-2023 02:00"),taskDateEnd: convertDate(data: "04-15-2023 03:00"),taskDuration: 1,taskColor:[0.9098, 0.6039,  0.6039], taskChecker: false),
    Task1(taskTitle: "Play games", taskDescription: "Play League",taskIcon: "gamecontroller.fill", taskDateStart: convertDate(data: "04-15-2023 12:20"),taskDateEnd:convertDate(data: "04-15-2023 13:20"),taskDuration: 1,taskColor: [0.32, 0.62,  0.81],taskChecker: false),
    Task1(taskTitle: "Go for a jog", taskDescription: "Light jog at central park",taskIcon: "figure.walk", taskDateStart: convertDate(data: "04-15-2023 13:20"),taskDateEnd: convertDate(data: "04-15-2023 13:50"),taskDuration: 0.5,taskColor: [0.467,  0.867, 0.467],taskChecker: false),
    Task1(taskTitle: "Make dinner", taskDescription: "Fried chicken with legumes",taskIcon: "cooktop.fill", taskDateStart: convertDate(data: "04-15-2023 14:50"),taskDateEnd: convertDate(data: "04-15-2023 15:50"),taskDuration: 1, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false),
    Task1(taskTitle: "Do laundry", taskDescription: "Remeber to do your laundy",taskIcon: "tshirt.fill", taskDateStart: convertDate(data: "04-15-2023 23:00"),taskDateEnd: convertDate(data: "04-15-2023 23:20"),taskDuration: (1/3), taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false),
    Task1(taskTitle: "Sleep", taskDescription: "Sleepytime",taskIcon: "moon.fill", taskDateStart:convertDate(data: "04-15-2023 23:20"),taskDateEnd: convertDate(data: "04-15-2023 23:50"),taskDuration: 0.5, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false)
]

private let temproutines = [
    Task1(taskTitle: "Wake up", taskDescription: "Wakey time 10-08",taskIcon: "sun.max.fill", taskDateStart: convertDate(data: "12-21-2022 01:00"),taskDateEnd:convertDate(data: "12-21-2022 01:30"),taskDuration: 0.5, taskColor:[0.949,  0.522,  0.1], taskChecker: false),
    Task1(taskTitle: "Sleep", taskDescription: "Sleepytime",taskIcon: "moon.fill", taskDateStart:convertDate(data: "12-21-2022 23:20"),taskDateEnd: convertDate(data: "12-21-2022 23:50"),taskDuration: 0.5, taskColor: [0.9098, 0.6039,  0.6039],taskChecker: false)
]
#endif
                            


struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let Dateobj = "04-15-2023"
        let DateObj = convertDate(data: Dateobj, format: "MM-dd-yyyy").startOfDay()
        let newItemDate = DateEntity(context: viewContext)
        newItemDate.dateGroup = DateObj
        
        
        for i in 0..<7 {
            let newItem = Tasks(context: viewContext)
            let dateEntity = TaskDate(context: viewContext)
            
            dateEntity.date = temp[i].taskDateStart
            newItem.addToDates(dateEntity)

            newItemDate.addToTaskDates(dateEntity)

            newItem.id = UUID()
            newItem.title = temp[i].taskTitle
            newItem.notes = temp[i].taskDescription
            newItem.icon = temp[i].taskIcon
            newItem.duration = temp[i].taskDuration * 3600
            newItem.color = temp[i].taskColor
            newItem.taskChecker = false
            newItem.addToHasDate(newItemDate)
        }
        
        let Date1 = "12-21-2022"
        let DateObj1 = convertDate(data: Date1, format: "MM-dd-yyyy").startOfDay()
        let newItemDate1 = DateEntity(context: viewContext)
        newItemDate1.dateGroup = DateObj1


        for i in 0..<7 {
            let newItem = Tasks(context: viewContext)
            let dateEntity = TaskDate(context: viewContext)
            dateEntity.date = temp1[i].taskDateStart
            newItem.addToDates(dateEntity)
            
            newItemDate1.addToTaskDates(dateEntity)

            newItem.id = UUID()
            newItem.title = temp1[i].taskTitle
            newItem.notes = temp1[i].taskDescription
            newItem.icon = temp1[i].taskIcon
            newItem.duration = temp1[i].taskDuration * 3600
            newItem.color = temp1[i].taskColor
            newItem.taskChecker = false
            newItem.addToHasDate(newItemDate1)
        }
        
        let newHabit = Habit(context: viewContext)
        newHabit.icon = "tray.fill"
        newHabit.completed = 5
        newHabit.frequency = 10
        newHabit.id = UUID()
        newHabit.title = "Drink Water"
        newHabit.color = [0.9098, 0.6039,  0.6039]
        newHabit.timeFrame = timeFrame.Weekly.rawValue
        newHabit.onDate?.adding(newItemDate)
        
        let habitDate = convertDate(data: "04-15-2023 16:00")
        newHabit.sched = [habitDate]
        
        let newHabit1 = Habit(context: viewContext)
        newHabit1.icon = "gamecontroller.fill"
        newHabit1.completed = 7
        newHabit1.frequency = 10
        newHabit1.id = UUID()
        newHabit1.title = "Drink Water"
        newHabit1.color = [0.9098, 0.4039,  0.4039]
        newHabit1.timeFrame = timeFrame.Weekly.rawValue
        
        let sched = Routine_Schedule(context: viewContext)
        let sched1 = Routine_Schedule(context: viewContext)
        sched.time = Date().startOfDay().addingTimeInterval(60*60*2)
        sched1.time = Date().startOfDay().addingTimeInterval(60*60*10)

        let array = [sched,sched1]
        
        for i in 0..<2{
            let newRoutine = Routine(context: viewContext)
            newRoutine.id = UUID()
            newRoutine.title = temproutines[i].taskTitle
            newRoutine.color = temproutines[i].taskColor
            newRoutine.notes = temproutines[i].taskDescription
            newRoutine.icon = temproutines[i].taskIcon
            newRoutine.duration = temproutines[i].taskDuration * 3600
            newRoutine.creationDate = (convertDate(data: Date1, format: "MM-dd-yyyy") )
            newRoutine.completed = 20
            newRoutine.notCompleted = .init(repeating: Date.now, count: 13)
            newRoutine.addToSchedule(array[i])
            for index in 0..<7 {
                let temp = DaysOfWeek(context: viewContext)
                temp.weekday = Int16(index)
                array[i].addToDaysofweek(temp)
                array[i].weekTracker = .init(repeating: false, count: 7)
            }
        }
        
        
        let projectItem = Project(context: viewContext)
        projectItem.subTasks = []
        projectItem.endDate = Date().addingTimeInterval(60*60*24*4)
        /*
        for i in 0..<7{
            if i%2 == 0 {
                times.append((true,[Date().startOfDay().addingTimeInterval(60*60*8)]))
            }
            else{
                times.append((false,[]))
            }
        }
        newRoutine.time = times
        */
        
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

    init(inMemory: Bool = true) {
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
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
}

class PersistentContainer: NSPersistentContainer {
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}



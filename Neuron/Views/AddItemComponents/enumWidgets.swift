//
//  TaskTree.swift
//  Neuron
//
//  Created by Alvin Wu on 12/12/22.
//

import Foundation

enum AddWidgets: Identifiable,CaseIterable,Comparable{
    
    case ColorPicker
    case DurationPicker
    case Routine_SubRoutines
    case Routine_Schedule
    case Notes
    case ProjectEndDateSelect
    case ProjectSubTasks
    case DatePicker
    case FrequencyPicker
    
    var id: String {return title}
    
    private var title: String{
        switch self {
        case .ColorPicker: return "Color Picker"
        case .DurationPicker: return "Duration Picker"
        case .FrequencyPicker: return "Frequency Picker"
        case .Routine_SubRoutines: return "Sub-Routines"
        case .Routine_Schedule: return "Routine Schedule"
        case .Notes: return "Notes"
        case .ProjectEndDateSelect: return "Project End Date"
        case .ProjectSubTasks: return "Project SubTasks"
        case .DatePicker: return "Date Picker"
        }
    }
    
    private var sortOrder: Int {
        switch self {
        case .ColorPicker:
            return .min
        case .DurationPicker:
            return 2
        case .ProjectEndDateSelect:
            return 3
        case .DatePicker:
            return 3
        case .FrequencyPicker:
            return 3
        case .ProjectSubTasks:
            return 4
        case .Routine_SubRoutines:
            return 4
        case .Routine_Schedule:
            return 5
        case .Notes:
            return .max
        }
    }
    
    static func ==(lhs: AddWidgets, rhs: AddWidgets) -> Bool {
        return lhs.sortOrder == rhs.sortOrder
    }
    
    static func <(lhs:AddWidgets, rhs: AddWidgets) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
}

let RoutineWidgets : [AddWidgets] = [.Notes,.ColorPicker,.DurationPicker,.Routine_SubRoutines,.Routine_Schedule].sorted(by: < )
let ProjectWidgets : [AddWidgets] = [.ColorPicker,.ProjectEndDateSelect,.ProjectSubTasks,.Routine_Schedule,.Notes]
let TaskWidgets : [AddWidgets] = [.ColorPicker,.DurationPicker,.DatePicker,.Notes]
let HabitWidgets : [AddWidgets] = [.ColorPicker, .DurationPicker, .FrequencyPicker, .Notes]

//
//  Symbol Picker Model.swift
//  Neuron
//
//  Created by Alvin Wu on 11/2/22.
//

import Foundation

public enum Category: String, CaseIterable, Identifiable {
    public var id: String { rawValue }
    
    case communication = "Communication"
    case weather = "Weather"
    case objects = "Objects"
    case devices = "Devices"
    case games = "Games"
    case transport = "Transport"
    case people = "People"
    case home  =  "Home"
    case fitness = "Fitness"
    case nature = "Nature"
    case edit = "Edit"
    case text = "Text"
    case multimedia = "Multimedia"
    case keyboard = "KeyBoard"
    case commerce = "Commerce"
    case time = "Time"
    case health = "Health"
    case forms = "Forms"
    case indices = "Indices"
    case math = "Math"
    case food = "Food"
    
    case none = ""
    
}

let symbols : [String: [String]] = [
    "Food" : ["wineglass.fill", "birthday.cake.fill","carrot.fill","gift.fill"]
]

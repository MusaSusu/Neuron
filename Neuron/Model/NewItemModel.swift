//
//  NewItemModel.swift
//  Neuron
//
//  Created by Alvin Wu on 11/13/22.
//

import Foundation
import SwiftUI

class NewItemModel: ObservableObject{
    var selection: Int = 0
    
    @Published var name: String = ""
    @Published var icon: String = "gift.fill"
    @Published var color: Color = Color(red: 0.5, green: 0.6039,  blue:0.8039)

    
    @Published var dateStart: Date = Date.now
    @Published var dateEnd: Date = Date.now.advanced(by: 300)
    @Published var duration: CGFloat = 30

    @Published var notes: String = ""
    
}

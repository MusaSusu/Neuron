//
//  WheelItemsModel.swift
//  Neuron
//
//  Created by Alvin Wu on 11/5/22.
//

import Foundation
import SwiftUI

class WheelItemsModel: ObservableObject{
    @Published var options : [String] = []
    @Published var selection : Int = 1
    
    init(_ selectedOption: [String]){
        self.options = selectedOption
    }
    
    func computeSelection(items: [CGFloat]){
        self.selection = items.firstIndex(of: 195.0) ?? 1
    }
    
    func maxDrag(dist: CGFloat)-> CGFloat{
        if dist < 0 {
            return max(dist,(-100*CGFloat(2-selection)))
        }
        return min(dist,100 * CGFloat(selection))
    }
}


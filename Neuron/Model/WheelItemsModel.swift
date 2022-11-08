//
//  WheelItemsModel.swift
//  Neuron
//
//  Created by Alvin Wu on 11/5/22.
//

import Foundation
import SwiftUI

class WheelItemsModel: ObservableObject{
    @Published var options : [String] = ["inbox","task","things","erc"]
    @Published var selection : Int = 0
    @Published var offset : [CGFloat] = [0.0,0.0,0.0,0.0]
    @Published var index : Int
    
    init(index: Int){
        self.index = index
    }
    
    func computeSelection(items: [CGFloat], dist: CGFloat, delta: CGFloat) -> CGFloat{
        var shift = Int(dist) / Int(delta * 0.75)
        if shift <= 0 {
           shift = max(self.selection-3,shift)
        }
        else if shift > 0{
            shift = min(self.selection,shift)
        }
        self.selection = self.selection - shift
        return CGFloat(delta * CGFloat(shift))
    }
    
    func maxDrag(dist: CGFloat, items: [CGFloat],delta: CGFloat, center: CGFloat,leftmax: CGFloat){
        var offset: CGFloat = 0.0
        
        index = index + 1
        
        if dist < 0 {
            offset = max(dist,(leftmax-items[0]))
        }
        else{
            offset = min(dist,center-items[0])
        }        
        for index in 0..<items.count{
            self.offset[index] = offset
        }
    }
}
        /*
         let endMax = (center * 2) - delta

         let location = items[index] + offset
         if location < 100 {
         self.offset[index] = offset - ( (location - 100) / 1.5)
         }
         else if location > endMax {
         self.offset[index] = offset - ((location - endMax) / 1.5)
         }
         else{
         self.offset[index] = offset
         }
         }*/

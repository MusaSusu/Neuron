//
//  WheelItemsModel.swift
//  Neuron
//
//  Created by Alvin Wu on 11/5/22.
//

import Foundation
import SwiftUI

class WheelItemsModel: ObservableObject{
    let options : [String] = ["Task","Project","Habit","Routine"]
    @Published var offset : [CGFloat] = [0.0,0.0,0.0,0.0]
    @Published var placements : [CGFloat]
    @Published var selection : Int = 0{
        didSet{
            updateLabel(withRange: oldValue - selection)
        }
    }
    
    var width : CGFloat
    var delta : CGFloat
    var leftDragMax : CGFloat
    var rightDragMax: CGFloat
    
    init(width: CGFloat){
        let wDim = min(width/10, 80)
        let delta = wDim*3
        let firstEle = wDim * 5

        self.delta = delta
        self.leftDragMax = {
            (wDim * 5) - (3 * delta) - firstEle
        }()
        self.rightDragMax = {
            (width / 2) - firstEle
        }()
        
        self.placements = {
            return [firstEle,firstEle + delta, firstEle + (2*delta),firstEle + (3*delta)]
        }()
        self.width = width
    }
    
    func updateLabel(withRange range: Int){
        placements = placements.map{$0 + CGFloat(delta * CGFloat(range))}
        rightDragMax = rightDragMax - placements[0]
        leftDragMax = leftDragMax - placements[0]
        offset = [0.0,0.0,0.0,0.0]
    }
    
    func computeSelection(dist: CGFloat){
        var shift = Int(dist) / Int(delta * 0.65)
        if shift <= 0 {
           shift = max(self.selection-3,shift)
        }
        else if shift > 0{
            shift = min(self.selection,shift)
        }
        self.selection = self.selection - shift
        offset = [0.0,0.0,0.0,0.0]
    }
    
    func applyOffset(_ dist: CGFloat){
        var off: CGFloat = 0
        
        if dist < 0 {
            off = max(dist,leftDragMax)
        }
        else{
            off = min(dist,rightDragMax)
        }        
        for index in 0..<4{
            offset[index] = off
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

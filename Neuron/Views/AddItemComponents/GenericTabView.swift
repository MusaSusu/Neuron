//
//  GenericTabView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/13/22.
//

import SwiftUI

struct GenericTabView: View {
    
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
    @EnvironmentObject var NewItem : NewItemModel
    var widgetsToLoad : [AddWidgets]
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing:10){
                
                ForEach(widgetsToLoad){ item in
                    addWidgetView(of: item)
                    if item != .Notes{
                        Divider().format()
                    }
                }
                
            }
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 20, trailing: 15))
            .backgroundStrokeBorder(opacity: 1, lineWidth: 2)
        }
    }
    
    @ViewBuilder
    func addWidgetView(of tab: AddWidgets) -> some View{
        switch tab {
        case .FrequencyPicker:
            FrequencyPickerDisc()
        case .DatePicker:
            DatePickerDisc()
        case .ProjectEndDateSelect:
            ProjectEndDateDisc()
        case .ProjectSubTasks:
            SubTaskAdderDisc()
        case .Routine_SubRoutines:
            SubRoutineAdderDisc()
        case .Routine_Schedule:
            RoutineSchedPickerDisc()
        case .Notes:
            NotesDisc()
        case .ColorPicker:
            ColorPickerDisc(color: $NewItem.color)
        case .DurationPicker:
            DurationPickerDisc()
        }
    }
}

struct GenericTabView_Previews: PreviewProvider {
    static var previews: some View {
        GenericTabView(widgetsToLoad: RoutineWidgets)
            .environmentObject(NewItemModel())
            .environmentObject(RoutineModel_Add())
    }
}

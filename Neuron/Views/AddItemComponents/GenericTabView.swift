//
//  GenericTabView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/13/22.
//

import SwiftUI

struct GenericTabView: View {
    @EnvironmentObject var NewItem : NewItemModel
    var widgetsToLoad : [widgets]
    
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
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white, strokeBorder: userColor)
                    .padding(.horizontal,1)
            )
        }.padding(.horizontal,5)
    }
    
    @ViewBuilder
    func addWidgetView(of tab: widgets) -> some View{
        switch tab {
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
            .environmentObject(RoutineViewModel())
    }
}

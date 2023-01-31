//
//  TimeLineMenu.swift
//  Neuron
//
//  Created by Alvin Wu on 12/15/22.
//

import SwiftUI

let ButtonOptions : [MenuWidgets:(String,Color,Bool) ] = [
    .description : ("pencil.and.ellipsis.rectangle",Color.green,true),
    .Routine_Completion : ("checkmark.circle.fill",Color.pink,true),
]


struct TimeLineMenu<content:View>: View {
    @Binding var selectedMenu : MenuWidgets
    var menuItems : [MenuWidgets]
    var taskButtonView : () -> content

    var body: some View {
        HStack{
            taskButtonView()
                Spacer()
            ForEach(menuItems,id:\.self) { item in
                checkInDict(for: item)
                Spacer()
            }
            Spacer()
        }
        .frame(height: 50)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 0.95))
        )
    }
    @ViewBuilder
    func checkInDict(for selection: MenuWidgets) -> some View{
        switch selection{
        case .Routine_Completion:
            createButton(for: .Routine_Completion)
        case .description:
            createButton(for: .description)
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func createButton(for selection: MenuWidgets) -> some View{
        Button{
            selectedMenu = selection
        } label: {
            Image(systemName: ButtonOptions[selection]!.0)
                .resizable()
                .aspectRatio(1,contentMode: .fit)
                .if(ButtonOptions[selection]!.2){ view in
                    view
                        .background(
                            Circle()
                                .inset(by: -7)
                                .strokeBorder()
                                .shadow(color: ButtonOptions[selection]!.1,radius: 1)
                        )
                }
        }
        .foregroundStyle(ButtonOptions[selection]!.1)
        .frame(width: 20,height: 20)
    }
}

struct TimeLineMenu_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineMenu(selectedMenu: .constant(.menu), menuItems: [.menu,.description,.none,.Routine_Completion], taskButtonView: {Menu_TaskCard_View(Task: previewsTasks)})
    }
}

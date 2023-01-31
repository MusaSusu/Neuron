//
//  TimeLineMenu.swift
//  Neuron
//
//  Created by Alvin Wu on 12/15/22.
//

import SwiftUI

let ButtonOptions : [MenuWidgets:(String,Color) ] = [
    .description : ("note.text",Color.yellow),
    .Routine_Completion : ("checkmark.circle.fill",Color.pink),
]


struct TimeLineMenu: View {
    @Binding var selectedMenu : MenuWidgets
    var menuItems : [MenuWidgets]

    var body: some View {
        HStack{
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
                .imageScale(.large)
                .background(
                    Circle()
                        .inset(by: -5)
                        .strokeBorder()
                        .shadow(radius: 0.1)
                        .opacity(0.95)
                )
        }
        .foregroundStyle(ButtonOptions[selection]!.1)
        .frame(width: 20,height: 20)
    }
}

struct TimeLineMenu_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineMenu(selectedMenu: .constant(.menu), menuItems: [.menu,.description,.none,.Routine_Completion])
    }
}

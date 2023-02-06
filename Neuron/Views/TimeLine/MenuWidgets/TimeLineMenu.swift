//
//  TimeLineMenu.swift
//  Neuron
//
//  Created by Alvin Wu on 12/15/22.
//

import SwiftUI

struct TimeLineMenu<content:View>: View {
    @Binding var selectedMenu : MenuWidgets
    var menuItems : [MenuWidgets]
    @ViewBuilder var taskButtonView : () -> content

    var body: some View {
        HStack{
            taskButtonView()
                Spacer()
            ForEach(menuItems,id:\.self) { item in
                createButton(for: item)
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

    func createButton(for selection: MenuWidgets) -> some View{
        Button{
            selectedMenu = selection
        } label: {
            Image(systemName: selection.buttonIcon)
                .resizable()
                .aspectRatio(1,contentMode: .fit)
        }
        .foregroundStyle(selection.buttonColor)
        .frame(width: 30,height: 30)
    }
}

extension MenuWidgets{
    
    var buttonIcon : String{
        switch self{
        case .description : return "pencil.and.ellipsis.rectangle"
        case .routine_completion : return "checkmark.circle.fill"
        default:
            return ""
        }
    }
    
    var buttonColor : Color{
        switch self{
        case .description : return .green
        case .routine_completion : return .pink
        default:
            return .clear
        }
    }
}

struct TimeLineMenu_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineMenu(selectedMenu: .constant(.menu),
                     menuItems: [.menu,.description,.none,.routine_completion],
                     taskButtonView: {EmptyView()}
            
        )
    }
}

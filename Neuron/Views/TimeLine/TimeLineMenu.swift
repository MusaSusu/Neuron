//
//  TimeLineMenu.swift
//  Neuron
//
//  Created by Alvin Wu on 12/15/22.
//

import SwiftUI

enum MenuWidgets: String,Identifiable,CaseIterable{
    case description
    case menu
    case none
    var id: Self{self}
}


struct TimeLineMenu: View {
    @Binding var selectedMenu : MenuWidgets
    var body: some View {
        HStack{
            Button{
                selectedMenu = .description
            } label: {
                Image(systemName: "note.text")
                    .imageScale(.large)
                    .background(
                        Circle()
                            .inset(by: -5)
                            .strokeBorder()
                            .shadow(color:.yellow,radius: 0.1)
                            .opacity(0.95)
                    )
            }
            .foregroundStyle(.yellow)
            
            Spacer()
        }
        .frame(height: 50)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 0.95))
        )
    }
}

struct TimeLineMenu_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineMenu(selectedMenu: .constant(.menu))
    }
}

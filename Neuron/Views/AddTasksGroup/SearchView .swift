//
//  SearchView .swift
//  Neuron
//
//  Created by Alvin Wu on 11/5/22.
//

import SwiftUI

struct SearchView_: View {
    @State private var taskName: String = ""
    @State private var isFocused: Bool = false

    var body: some View {
        VStack{
            //TITLE / SEARCH
            HStack{
                Spacer()
                Text("Add Task").font(.title.bold())
                    .foregroundColor(userColor)
                Spacer()
            }.padding(.vertical)
            
            Divider()
                .background(.blue)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            //MARK: Search Bar / Title Input
            HStack{
                TextField(
                    "Something to do...",
                    text: $taskName,
                    onEditingChanged: {_ in isFocused.toggle()}
                )
                .customStyle()
                .background{
                    ZStack{
                        RoundedRectangle(cornerRadius: 25,style: .continuous)
                            .fill(Color(white:0.99))
                        RoundedRectangle(cornerRadius: 25,style: .continuous)
                            .strokeBorder(
                                userColor,
                                lineWidth: isFocused ? 4 : 2
                            )
                    }
                }
            }
            ScrollView(.vertical,showsIndicators: true){
                VStack{
                    //Show tasks that have the same title. Also right below have 3 selections to pick what kind of task you want to add.
                }
            }
        }
        .padding(10)
        .ignoresSafeArea(edges:.bottom)
        .background(
            Color(white : 0.95)
        )
    }
}

struct SearchView__Previews: PreviewProvider {
    static var previews: some View {
        SearchView_()
    }
}

extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: Double = 3) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(
                self.fill(fillStyle)
            ).padding(1)
    }
}

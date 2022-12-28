//
//  SearchView .swift
//  Neuron
//
//  Created by Alvin Wu on 11/5/22.
//

import SwiftUI

struct SearchView_: View {
    @EnvironmentObject var NewItem : NewItemModel
    @State private var isFocused = false
    
    var body: some View {
        
        HStack{
            
            ZStack{
                Circle()
                    .fill(NewItem.color)
                    .frame(width: 40)
                Rectangle()
                    .fill(.white)
                    .mask{
                        Image(systemName:NewItem.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25.0, height: 25.0)
                    }
            }.frame(width: 40).offset(x:10)
            
            TextField(
                "Something to do...",
                text: $NewItem.name,
                onEditingChanged: {_ in isFocused.toggle()}
            ).customStyle()
        }
        .background{
            ZStack{
                RoundedRectangle(cornerRadius: 25,style: .continuous)
                    .fill(Color(white:0.99))
                RoundedRectangle(cornerRadius: 25,style: .continuous)
                    .strokeBorder(
                        userColor,
                        lineWidth: isFocused ? 4 : 2
                    )
            }.frame(height: 60)
        }.frame(height: 80)
    }
}

struct SearchView__Previews: PreviewProvider {
    static var previews: some View {
        SearchView_().environmentObject(NewItemModel())
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

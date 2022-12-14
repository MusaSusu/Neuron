//
//  DateListItem.swift
//  Neuron
//
//  Created by Alvin Wu on 11/10/22.
//

import SwiftUI

struct DateListRow: View {
    @EnvironmentObject var DateList : DateListModel
    @Binding var date : dateItem
    let index: UUID
    
    init(date: Binding<dateItem>,index:UUID){
        _date = date
        self.index = index
    }
    

    var body: some View {
        
        Button{
            DateList.isPop.toggle()
            DateList.editItem(date)
        }label: { Label{Text("Edit Item") } icon:
            {
                HStack(spacing:5){
                    HStack{
                        Text(date.date, format: Date.FormatStyle().weekday(.wide))
                        Divider()
                        Text(date.date, format: Date.FormatStyle().month().day().year().hour().minute())
                    }
                    .foregroundColor(.black)
                    .frame(maxHeight:20)
                    .font(.title3.weight(.regular))
                }
                .padding(5)
            }
        }
        .labelStyle(.iconOnly)
        .disabled(!DateList.isEditOn)
    }
}

struct DateListRow_Previews: PreviewProvider {
    static var previews: some View {
        DateListRow(date: .constant(dateItem(id: UUID(), date: Date())),index: UUID()).environmentObject(DateListModel())
    }
}

extension Rectangle{
}

/*
 .coordinateSpace(name: index)
 .border(isBorder ? .red : .white)
 .gesture(
 DragGesture(minimumDistance: 10,coordinateSpace: .named(index))
 .onEnded({ value in
 if value.translation.width < 0 && value.translation.height > -5 && value.translation.height < geometry.size.height {
 isBorder.toggle()
 }
 else if value.translation.width > 0 && value.translation.height > -5 && value.translation.height < geometry.size.height {
 }
 })
 )
 
 Button{
 DateList.deleteDate(item: date)
 } label: {
 Label("Delete Date", systemImage: "minus.circle.fill")
 }
 .imageScale(.large)
 .foregroundColor(.red)
 .labelStyle(.iconOnly)
 
 */

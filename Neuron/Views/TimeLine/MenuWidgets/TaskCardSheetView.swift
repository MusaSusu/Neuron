//
//  TaskCardSheetView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/31/23.
//

import SwiftUI

enum CardItems : Identifiable,Comparable,Hashable{
    case DateCard(taskType)
    case Notes
    
    var id: Int{return val}
    
    var val : Int{
        switch self{
        case .DateCard : return 1
        case .Notes : return 2
            
        }
    }
    
    var buttonLabel : String{
        switch self{
        case .DateCard : return "calendar"
        case .Notes: return "note.text"
        }
    }
    
    var color : Color{
        switch self{
        case .DateCard : return .red
        case .Notes : return .yellow
        }
    }
    
    static func < (lhs: CardItems, rhs: CardItems) -> Bool {
        lhs.val < rhs.val
    }
    
}


enum TypeCard{
    case Task
    case Routine
}

let ButtonLabels : [CardItems.ID : (String,Color)] = [
    1 : ("calender",.red)
]


struct TaskCardSheetView<T: isTimelineItem>: View {
    
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
        
    @ObservedObject var Item : T
    @State var selection : CardItems
    @State var menuItems : [CardItems]

    let width : CGFloat

    var body: some View {
        VStack(spacing:10){
            
            TitleView()
            
            HStack(spacing: 10){
                Spacer()
                
                ForEach(menuItems){item in
                    Button{
                        selection = item
                    }label: {
                        IconView(color: .white,
                                 backgroundColor: item.color,
                                 icon: item.buttonLabel,
                                 dims: .init(width: 25, height: 25)
                        ).frame(width: 35,height: 35)
                    }
                }
                
                Spacer()
            }
            
            SelectedMenuView()
            
            HStack{
                
            }
        }
        .frame(width: width * 0.75,alignment: .leading)
        .padding(20)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 0.9), strokeBorder: userColor,lineWidth: 2)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    
    @ViewBuilder
    func SelectedMenuView() -> some View{
        switch selection {
            
        case .DateCard(let typeCard):
            
            HStack{
                Text("Duration")
                Spacer()
                Text(Item.duration.toHourMin(from: .seconds))
            }
            .padding(10)
            .backgroundStrokeBorder(opacity: 1, lineWidth: 0)
            
            switch typeCard{
            case .Task:
                DateCard_Task_View(Task: Item as! Tasks)
            default:
                EmptyView()
            }
            
        case .Notes:
            Notes_Card_View(notesString: .init(get: {Item.notes},
                                               set: {newval in Item.notes = newval}
                                              ))
        }
    }
    
    func TitleView() -> some View{
        HStack{
            ZStack{
                IconView(color: Item.getColor(), icon: Item.icon!, dims: .init(width: 25, height: 25))
            }
            .frame(width: 40).padding(.leading,10)
            
            Spacer()
            Text(Item.title!).titleFont().offset(x:-20)
            Spacer()
        }   
        .background{
                RoundedRectangle(cornerRadius: 25,style: .continuous)
                    .fill(Color(white:0.99))
                    .frame(height: 60)
        }.frame(height: 80)
    }
}

struct TaskCardSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardSheetView<Tasks>(Item: previewsTasks,
                                 selection: .DateCard(.Task),
                                 menuItems: [CardItems.DateCard(.Task),.Notes],
                                 width: 400)
        .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}


struct StrokeBackgroundBorder : ViewModifier{
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
    let opacity : CGFloat
    let lineWidth : CGFloat
    
    func body(content: Content) -> some View {
        content
            .background{
                RoundedRectangle(cornerRadius: 10,style: .circular)
                    .fill(Color(white: opacity), strokeBorder: userColor,lineWidth: lineWidth)
            }
    }
}

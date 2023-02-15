//
//  InboxView.swift
//  Neuron
//
//  Created by Alvin Wu on 2/14/23.
//

import SwiftUI

struct InboxView: View {
    
    @UserDefaultsBacked<[Double]>(key: .userColor) var dataColor
    var userColor : Color{
        dataColor?.fromDouble() ?? .black
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest private var Routines : FetchedResults<Routine>
    @FetchRequest private var Tasks : FetchedResults<Tasks>
    @FetchRequest private var Habits : FetchedResults<Habit>
    @FetchRequest private var Projects : FetchedResults<Project>
    
    var routineItems: [Routine]{
        Routines.compactMap({$0})
    }
    
    var taskItems : [Tasks] {
        Tasks.compactMap({$0})
    }
    
    var habitItems : [Habit] {
        Habits.compactMap({$0})
    }
    
    var projectItems : [Project] {
        Projects.compactMap({$0})
    }
    
    
    init(){
        _Routines = FetchRequest(sortDescriptors: [])
        _Tasks = FetchRequest(sortDescriptors: [])
        _Habits = FetchRequest(sortDescriptors: [])
        _Projects = FetchRequest(sortDescriptors: [])
    }
    
    @State private var routineExpand : Bool = true

    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                Spacer()
                Text("Storage")
                    .font(.largeTitle.weight(.semibold))
                    .foregroundColor(.black)
                Spacer()
            }.padding(.top,10)
            
            Divider()
            
            ScrollView(.vertical){
                LazyVStack(pinnedViews: .sectionHeaders){
                    
                    ItemRow(items: routineItems,section: "Routines")
         
                    ItemRow(items: habitItems, section: "Habits")
                    
                    ItemRow(items: taskItems, section: "Tasks")
                    
                    Spacer()
                    
                }
                HStack{
                    Spacer()
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(10)
        .backgroundStrokeBorder(opacity: 0.95, lineWidth: 3)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder
    func ItemRow<T:Main>(items: [T],section: String)->some View{
        
        Section(
            content:{
                LazyVStack{
                    ForEach(items){item in
                        HStack{
                            
                            IconView(color: item.getColor(), icon: item.icon!, dims: CGSize(width: 30, height: 30))
                                .frame(width: 40,height: 40)
                                .padding(.horizontal)
                            
                            HStack{
                                Text(item.title!)
                                    .font(.title2.weight(.regular))
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                        }.frame(height: 50)
                        
                        Divider()
                    }
                }
                .padding(10)
                .backgroundStrokeBorder(opacity: 1, lineWidth: 2)
                .padding(10)
            },
            header: {
                HStack{
                    Text(section)
                        .font(.system(.title2,design: .default,weight: .medium))
                        .foregroundColor(.black)
                        .padding(.leading,5)
                    Spacer()
                }
                .padding(.bottom,5)
                .background{
                    Color(white: 0.95)
                }
            })
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

private extension View{
    func headerFont()-> some View{
        self
            .font(.system(.headline, design: .default, weight: .semibold))
    }
}

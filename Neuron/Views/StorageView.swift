//
//  InboxView.swift
//  Neuron
//
//  Created by Alvin Wu on 2/14/23.
//

import SwiftUI

struct StorageView: View {
    
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
        Tasks.filter({$0.isRecurring == true})
    }
    
    var habitItems : [Habit] {
        Habits.compactMap({$0})
    }
    
    var projectItems : [Project] {
        Projects.compactMap({$0})
    }
    
    var collection : [ ([Main],String)] {
        return [
            (taskItems,"Tasks"),
            (projectItems,"Projects"),
            (routineItems,"Routines"),
            (habitItems,"Habits")
        ]
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
                    
                    ForEach(collection.indices, id:\.self){ index in
                        let items = collection[index].0
                        let titleLabel = collection[index].1
                        
                        if items.count == 0{
                        }
                        else {
                           ItemRow(items: items, section: titleLabel)
                        }
                    }

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
                        Spacer()
                        HStack{
                            
                            IconView(color: item.getColor(), icon: item.icon!, dims: CGSize(width: 30, height: 30))
                                .frame(width: 40,height: 40)
                                .padding()
                            
                            HStack{
                                Text(item.title!)
                                    .font(.title2.weight(.regular))
                            }
                            .padding()
                            
                            Spacer()
                        }.frame(height: 50)
                        
                        Divider().padding(.horizontal,20)
                    }
                }
                .backgroundStrokeBorder(opacity: 1, lineWidth:1)
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
    
    
    func checkCount<T: Main>(items : [T]) -> Bool {
        if items.count == 0 {
            return false
        }
        else {
            return true
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}

private extension View{
    func headerFont()-> some View{
        self
            .font(.system(.headline, design: .default, weight: .semibold))
    }
}

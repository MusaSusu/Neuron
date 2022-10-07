//
//  FullTimelineView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/3/22.
//



let apple = "dkfmdskfkmsdkmfsdkmfdskmdsfkmsfdmksdfmksdf"
let apple1 = "p'kasgkmpdkpjsgijpdfjpgjpdsfpjdfgpjofgsdopfgdopfdsopkgsopfdgopdsfgkopfdksopkpgofdskpogsdpkodsg  gdsfkongdksngdf g dfsg odfs"

let apple2 = "fdijosafijooijs kkk dafoijdsajoigfjodfgojigsfdojdfgsjodsfoiing"
import SwiftUI

struct FullTimelineView: View {
    
    @ObservedObject var Options: OptionsModel = OptionsModel()
    @StateObject var DayTasks: DayTaskModel = DayTaskModel()
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            //MARK: TODO: Add a function that takes an array of the tasks for the day,so I have the start and end times of every task, so then I can divide the entire day up while using taskview to create the entire view
            VStack(spacing:0){
                ForEach(DayTasks.taskStorage, id: \.id) { task in
                    TimelineRowView(icon: task.taskIcon, duration: task.taskDuration, text: task.taskDescription,dateStart: task.taskDateStart,dateEnd: task.taskDateEnd,setColor: task.taskColor)
                    
                }
            }
        }
    }
}

struct FullTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        FullTimelineView()
    }
}

extension View {
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
    }
}

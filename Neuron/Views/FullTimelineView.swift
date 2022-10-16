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
    
    @EnvironmentObject var data: DataSource

    var date: String
    var body: some View {

        ScrollView(.vertical,showsIndicators: false){
            //MARK: TODO: Add a function that takes an array of the tasks for the day,so I have the start and end times of every task, so then I can divide the entire day up while using taskview to create the entire view
            
            VStack(spacing:0){
                ForEach(data.taskDataByDate[date] ?? ["1"], id: \.self) { task in
                    let temp = data.taskData[task]!
                    let tuple = data.getTimeInterval(date: date, id: task)
                    TimelineRowView(id: temp.id,icon: temp.taskIcon, duration: temp.taskDuration,taskTitle: temp.taskTitle, text: temp.taskDescription,dateStart: temp.taskDateStart,dateEnd: temp.taskDateEnd,setColor: temp.taskColor,prevDuration: tuple.0,nextDuration: tuple.1)
                }
            }
            VStack{
                
            }.frame(height:300)
            }
        }
    }


struct FullTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        FullTimelineView(date:"10-05-2022").environmentObject(DataSource())
    }
}

extension View {
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
    }
}

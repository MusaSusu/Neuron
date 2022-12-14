//
//  SubTaskAdderDisc.swift
//  Neuron
//
//  Created by Alvin Wu on 12/13/22.
//

import SwiftUI

struct SubTaskAdderDisc: View {
    var body: some View {
        HStack{
            DisclosureGroup(content: {SubTaskAdder()},
                            label: {Text("SubTasks").titleFont() }
            )
        }
    }
}

struct SubTaskAdderDisc_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskAdderDisc().environmentObject(ProjectModel())
    }
}

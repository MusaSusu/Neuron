//
//  RoutineDiscGroupView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/13/22.
//

import SwiftUI

struct SubRoutineAdderDisc: View {
    var body: some View {
        DisclosureGroup{
            SubRoutineListView()
        } label: {
            Text("Sub-Routine").titleFont()
        }
    }
}

struct RoutineSchedAdderDisc_Previews: PreviewProvider {
    static var previews: some View {
        SubRoutineAdderDisc()
            .environmentObject(RoutineModel())
    }
}

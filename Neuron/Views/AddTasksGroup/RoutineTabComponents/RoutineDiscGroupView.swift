//
//  RoutineDiscGroupView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/13/22.
//

import SwiftUI

struct RoutineDiscGroupView: View {
    var body: some View {
        DisclosureGroup{
            RoutineMakerView()
        } label: {
            Text("Sub-Routine").titleFont()
        }
    }
}

struct RoutineDiscGroupView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineDiscGroupView()
            .environmentObject(RoutineViewModel())
    }
}

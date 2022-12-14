//
//  ProjectEndDateDisc.swift
//  Neuron
//
//  Created by Alvin Wu on 12/13/22.
//

import SwiftUI

struct ProjectEndDateDisc: View {
    @EnvironmentObject var Project : ProjectModel
    
    var body: some View {
        HStack{
            Text("End Date").titleFont()
            // Select 2 weeks,month,3 months, 6 months etc. or custom due date.
            Spacer()
            DatePicker(
                "Add Date",
                selection: $Project.date,
                displayedComponents: [.date]
            ).labelsHidden()
        }
    }
}

struct ProjectEndDateDisc_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEndDateDisc()
            .environmentObject(ProjectModel())
    }
}

//
//  testview.swift
//  Neuron
//
//  Created by Alvin Wu on 1/18/23.
//

import SwiftUI

struct testview: View {
    @FetchRequest<Routine>(sortDescriptors: []) var routines
    var items : [Routine] {
        routines.compactMap({$0})
    }
    var body: some View {
        VStack{
            ForEach(items){item in
                Text((item.tempsched.debugDescription))
            }
        }
    }
}

struct testview_Previews: PreviewProvider {
    static var previews: some View {
        testview()            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)

    }
}

//
//  HeaderButtonsView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/27/22.
//

import SwiftUI

struct HeaderButtonsView: View {
    @State private var showingSheet = false
    
    var body: some View {
        HStack{
            Button{
                showingSheet.toggle()
            }label: {
                Label{Text("Add Task")} icon: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(Color(red: 0.9, green: 0.6039,  blue:0.6039))
                }
            }
            .labelStyle(.iconOnly)
            .sheet(isPresented: $showingSheet) {
                AddTaskView()
                
            }
        }.frame(width:60,height:60)
    }
}

struct HeaderButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderButtonsView()
    }
}

//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 9/25/22.
//

import SwiftUI

struct BottomTabView: View {
    var body: some View {
        VStack{
            
            HStack {
                
                Button(action: openInbox) {
                    VStack{
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(Color(white:0.5))
                        Text("Today")
                            .foregroundColor(Color(white:0.5))
                    }
                }.frame(maxWidth: .infinity)
                
                Button(action: openInbox) {
                    VStack{
                        Image(systemName: "tray")
                            .font(.title)
                            .foregroundColor(Color(white:0.5))
                        Text("Inbox")   
                            .foregroundColor(Color(white:0.5))
                    }
                }.frame(maxWidth: .infinity)
                

                HeaderButtonsView().offset(y: -20)

                Button(action: openInbox) {
                    VStack{
                        Image(systemName: "brain")
                            .font(.title)
                            .foregroundColor(Color(white:0.5))
                        Text("Inbox")
                            .foregroundColor(Color(white:0.5))
                    }
                }.frame(maxWidth: .infinity)
                
                Button(action: openInbox) {
                    VStack{
                        Image(systemName: "tray.fill")
                            .font(.title)
                            .foregroundColor(Color(white:0.5))
                        Text("Inbox")
                            .foregroundColor(Color(white:0.5))
                    }
                }.frame(maxWidth: .infinity)
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            .frame(maxWidth: .infinity, minHeight: 30, maxHeight:70)
            .background(Color(white:0.95))
        }
    }
}

func openInbox(){
    
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
    }
}

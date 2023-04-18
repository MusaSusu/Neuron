//
//  SwiftUIView.swift
//  Neuron
//
//  Created by Alvin Wu on 9/25/22.
//

import SwiftUI

struct BottomTabView: View {
    @State var isSheet : Bool = false
    @State var inboxSheet : Bool = false
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {isSheet.toggle()}) {
                    VStack{
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(Color(white:0.5))
                        Text("Today")
                            .foregroundColor(Color(white:0.5))
                    }
                }
                .sheet(isPresented: $isSheet){
                    
                }
                Spacer()
                Button(action: {inboxSheet = true}) {
                    VStack{
                        Image(systemName: "tray")
                            .font(.title)
                            .foregroundColor(Color(white:0.5))
                        Text("Inbox")   
                            .foregroundColor(Color(white:0.5))
                    }
                }
                .sheet(isPresented: $inboxSheet){
                    StorageView()
                }
                
                Spacer()
                

                AddTaskButtonView().offset(y: -20)
                    .shadow(radius: 1)
                    .blendMode(.sourceAtop)

                Spacer()
                
                Button(action: openInbox) {
                    VStack{
                        Image(systemName: "brain")
                            .font(.title)
                            .foregroundColor(Color(white:0.5))
                        Text("Inbox")
                            .foregroundColor(Color(white:0.5))
                    }
                }
                
                Spacer()
                
                Button(action: openInbox) {
                    VStack{
                        Image(systemName: "tray.fill")
                            .font(.title)
                            .foregroundColor(Color(white:0.5))
                        Text("Inbox")
                            .foregroundColor(Color(white:0.5))
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading:15, bottom: 5, trailing: 15))
            .background(Color(white:0.95))
            .frame(maxWidth: .infinity, minHeight: 30, maxHeight:70)
        }.padding(.bottom,10)
    }
}

func openInbox(){
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
    }
}

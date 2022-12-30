//
//  PopUpCoverView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/21/22.
//

import SwiftUI

struct PopUpCoverView<Content:View> : View {
    @ViewBuilder var content : Content
    
    @ViewBuilder
    func showPop() -> some View {
        switch isPop{
        case .DatePop:
                DatePickerSheet()
        case .RoutinePop:
            EmptyView()
        case .none:
            EmptyView()
        }
    }
    
    @State var isPop : PopUp_Adder = .none
    
    var body: some View {
        ZStack{
            content
                .opacity(isPop != .none ? 0.5 : 1)
                .disabled(isPop != .none)
                
            showPop()
            }
        }
    }


struct PopUpCoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpCoverView(content: {EmptyView()})
    }
}

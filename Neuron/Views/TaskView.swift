//
//  TImeLineView.swift
//  Neuron
//
//  Created by Alvin Wu on 10/2/22.
//

import SwiftUI

struct TaskView: View {
    let icon: String
    let duration: CGFloat
    let text: String
    
    var length: CGFloat{
        let duration1 = (duration/0.5)
        if duration1 <= 1 {
            return 40
        }
        else if duration1 >= 6 {
            return 240
        }
        else {
            return 40 * duration1
        }
    }

    let string = "20:32 Wed, 30 Oct 2019"
    
    var body: some View {
        HStack(spacing:0){
            
            HStack{
                leftView(icon: "moon.fill", duration: duration)
            }
            
            HStack{
                Text(text)
                Spacer()
            }
            .padding(5)
            .frame(width:.infinity,height:length+60,alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red:0.32,green: 0.62, blue: 0.81)).opacity(0.3)
                        .shadow(radius: 5)
                )
            
            Spacer()
            
        }
        .frame(height: length+90)
    }
}

    
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(icon: "moon.fill",duration: 0.5, text: "dkfmdskfkmsdkmfsdkmfdskmdsfkmsfdmksdfmksdf")
    }
}


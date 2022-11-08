//
//  AddRoutineView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/5/22.
//

import SwiftUI

struct AddRoutineTab: View {
    @Binding var taskDuration: CGFloat
    @Binding var taskColor: Color
    @Binding var taskNotes: String
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing:10){
                
                Group{
                    HStack{
                        DisclosureGroup{
                            HStack{
                                Slider(
                                    value:$taskDuration,
                                    in: 0...120,
                                    step: 5
                                )
                            }.padding(.top,10)
                            HStack{
                                Spacer()
                                Button("Custom Time") {
                                    
                                }
                            }
                        } label: {
                        }
                        .padding(.top,3)
                        .alignmentGuide(VerticalAlignment.center) {_ in 30}
                        .overlay{
                            
                            HStack(spacing:0){
                                Text("Duration").titleFont()
                                Spacer()
                                Text("\(createDateString(duration:taskDuration))")
                                    .titleFont()
                            }
                            .alignmentGuide(VerticalAlignment.center) {_ in 30}
                            .background(.white).padding(.trailing,25)
                        }
                    }.padding(.top)
                }
                
                
                Divider().format()
                //COLOR PICKER
                HStack{
                    DisclosureGroup{
                        CustomColorPickerView(selectedColor: $taskColor)
                    } label: {
                        HStack{
                            Text("Color").titleFont()
                            Spacer()
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .foregroundColor(taskColor)
                                .frame(width: 40).offset(x:-5)
                        }
                    }
                }
                
                Divider().format()
                //NOTES
                
                HStack{ Text("Notes").titleFont(); Spacer()}
                
                TextEditor(text: $taskNotes)
                    .scrollContentBackground(.hidden)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.yellow)
                    )
                    .frame(minHeight: 175,maxHeight: 250)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                
                Spacer()
            } // End of ScrollView
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 20,style: .continuous)
                    .fill(.white, strokeBorder: userColor)
            )
        }
        .frame(minWidth:300)
    }
}

struct AddRoutineTab_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineTab(taskDuration: .constant(10), taskColor: .constant(.blue),taskNotes: .constant("Notes"))
    }
}

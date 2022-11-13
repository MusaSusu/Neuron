//
//  AddTabView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/8/22.
//

import SwiftUI

struct AddTaskTab: View {
    @StateObject var DateList = DateListModel()
    
    @State private var timer: CGFloat = 0
    
    @Binding var taskDuration: CGFloat
    @Binding var taskColor: Color
    @Binding var taskNotes: String
    
    let transition = AnyTransition.asymmetric(insertion: .scale, removal: .scale).combined(with: .opacity)
    
    var body: some View {
        ZStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:10){
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
                    
                    //Duration
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
                                Text("Duration").hidden()
                            }
                            .padding(.top,3)
                            .alignmentGuide(VerticalAlignment.center) {_ in 30}
                            .background{
                                HStack(spacing:0){
                                    Text("Duration").titleFont()
                                    Spacer()
                                    Text("\(createDateString(duration:taskDuration))")
                                        .titleFont()
                                }
                                .alignmentGuide(VerticalAlignment.center) {_ in 30}
                                .background(.white).padding(.trailing,25)
                            }
                        }
                    }
                    
                    Divider().format()
                    //Dates
                    Group{
                        ZStack{
                            HStack{
                                DisclosureGroup{
                                    VStack{
                                        DatePickerView().environmentObject(DateList)
                                    }.padding(.top)
                                } label:{
                                    HStack{
                                        Text("Date").titleFont()
                                        
                                        Spacer()
                                        
                                        Image(systemName: "calendar")
                                            .resizable()
                                            .aspectRatio(contentMode: ContentMode.fill)
                                            .frame(width: 25,height: 25)
                                            .foregroundColor(DateList.addDateCheck ? .black : Color(white: 0.5))
                                        
                                        Divider().padding(.horizontal)
                                        
                                        Image(systemName: "tray")
                                            .resizable()
                                            .aspectRatio(contentMode: ContentMode.fill)
                                            .frame(width: 25,height: 25)
                                            .foregroundColor(DateList.addInboxCheck ? .black : .white)
                                    }.padding(.trailing,10)
                                }
                            }
                            HStack{
                                if DateList.isPop{
                                    
                                    DatePickerModal().environmentObject(DateList)
                                        .transition(.asymmetric(insertion: .scale, removal: .scale))
                                }
                            }.animation(.default.speed(0.75), value: DateList.isPop)
                        }
                    }
                    
                    Divider().format()
                    
                    //NOTES
                    Group{
                        HStack{ Text("Notes").titleFont(); Spacer()}
                        
                        TextEditor(text: $taskNotes)
                            .scrollContentBackground(.hidden)
                            .keyboardType(.default)
                            .scrollDismissesKeyboard(.immediately)
                            .frame(minHeight: 175,maxHeight: 250)
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.yellow)
                            )
                        
                        Spacer()
                    }
                } // End of ScrollView
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 20,style: .continuous)
                        .fill(.white, strokeBorder: userColor)
                )
            }.padding(.horizontal,5)
            
        }
    }
}

struct AddTaskTab_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskTab(taskDuration: .constant(10), taskColor: .constant(.red),taskNotes: .constant("Notes"))
    }
}

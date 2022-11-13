//
//  CustomColorPickerView.swift
//  Neuron
//
//  Created by Alvin Wu on 11/1/22.
//
//MARK: ADD A NEW COLOR PICKER. SWIFT'S SUCKS AND PRECURATED PACKAGES.
import SwiftUI

struct CustomColorPickerView: View {
    let colors = [Color.red,Color.blue,Color.yellow,Color.orange,Color.gray,]
    @State private var checker: Bool = false
    @Binding var selectedColor: Color
   
    var colorsCount: Int {colors.count}
    var midIndex: Int{
        if colorsCount % 2 == 0 {
            return colorsCount/2
        }
        return (colorsCount/2) + 1
    }
    
    var body: some View {
        VStack(spacing:0){
            Divider().frame(height:1).background(userColor).padding(10)
            HStack{
                Spacer()
                VStack(spacing: 0){
                    HStack{
                        Text("Saved").bold()
                    }.frame(height:20)
                    
                    Divider().background(.red).padding(.horizontal)
                    
                    ScrollView(.vertical,showsIndicators:false){
                        HStack(spacing:0){
                            ContainerView(selectedColor: $selectedColor, items: colors[..<midIndex])
                        }
                    }
                }.frame(height:110)
                
                VStack(spacing:0){
                    HStack{
                        Text("Pastel").bold()
                    }.frame(height:20)
                    
                    Divider().background(.red).padding(.horizontal)
                    
                    ScrollView(.vertical,showsIndicators:true){
                        HStack(spacing:0){
                            ContainerView(selectedColor: $selectedColor, items: colors[midIndex...])
                        }
                    }
                }.frame(height:110)
                
                VStack{
                    HStack{
                        Text("New Color").font(.callout).bold()
                    }
                    
                    ZStack{
                        ColorPicker("Select New Color",
                                    selection: $selectedColor,
                                    supportsOpacity: false
                        )
                        .labelsHidden()
                        .opacity(0.15)
                        
                        Circle()
                            .fill(
                                AngularGradient(
                                    colors: hueColors,
                                    center: .center,
                                    startAngle: .zero,
                                    endAngle: .degrees(360))
                            )
                            .allowsHitTesting(false)
                    }.frame(width: 30)
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        
                        Button{
                            Edit()
                        } label:{
                            Label { Text("Edit").font(.footnote)} icon:{
                                Image(systemName: "pencil").imageScale(.small)
                            }
                        }
                    }
                }.frame(width: 80)
            }
        }.frame(height:120)
    }
}

struct CustomColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomColorPickerView(selectedColor: .constant(Color.red))
    }
}

private struct ContainerView: View {
    @Binding var selectedColor: Color
    var items: ArraySlice<Color>
    
    var body: some View {
        VStack{
            ForEach(items, id: \.self) {item in
                HStack(spacing: 0){
                    VStack{
                        Text("hellok0wao").scaledToFill()
                    }.frame(minWidth:80,minHeight: 20,maxHeight: 20)
                    VStack{
                        Button {
                            selectedColor = item
                        } label: {
                            Label {Text("Task Complete")} icon: {
                                Image(systemName: "circle.inset.filled")
                                    .foregroundColor(item)
                                    .imageScale(.large)
                            }
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(PlainButtonStyle())
                        
                    }.frame(width:30,height: 20)
                }.frame(height: 20)
            }
            Spacer()
        }.frame(minHeight: 100).padding(.top,5)
    }
}

private func Edit() -> Void{
    
}

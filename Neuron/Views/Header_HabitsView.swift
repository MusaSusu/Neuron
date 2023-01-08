//
//  Header_HabitsView.swift
//  Neuron
//
//  Created by Alvin Wu on 1/5/23.
//

import SwiftUI

struct Header_HabitsView: View {
    
    @FetchRequest<Habit>(sortDescriptors: []) var items
    
    
    var body: some View {
        HStack(spacing: 20){
            ForEach(items){ item in
                drawIcon(item)
            }
            Spacer()
        }.frame(maxWidth: .infinity).padding(.horizontal)
    }
    
    struct CircleBorder : Shape {
        let factor : Double
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midY, startAngle: .degrees(-90), endAngle: .degrees((factor * 360) - 90), clockwise: false)
            path = path.strokedPath(StrokeStyle(lineWidth: 2.5,lineCap: .round))
            return path
        }
    }
    
    func drawIcon(_ habit : Habit) -> some View {
        ZStack{
            Capsule()
                .fill(Color(white: 0.95))
                .frame(width: 45,height: 45)
            CircleBorder(factor: Double(habit.completed) / Double(habit.frequency)  )
                .fill(habit.color?.fromDouble() ?? .red)
                .frame(width: 45,height: 45)
            Circle()
                .fill(habit.color?.fromDouble() ?? .red)
                .mask(Image(systemName:"gift.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25.0, height: 25.0)
                )
        }.frame(width: 45,height: 45)
    }
}

struct Header_HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        Header_HabitsView()            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)

    }
}

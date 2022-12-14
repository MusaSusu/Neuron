//
//  RoutineView.swift
//  Neuron
//
//  Created by Alvin Wu on 12/4/22.
//

import SwiftUI

struct RoutineMakerView: View {
    @EnvironmentObject var RoutineModel : RoutineViewModel
    
    @State private var selectedRoutine : Routine?
    @FocusState private var isFocus : isRowFocus?
    @State private var isSheet : Bool = false
    @Environment(\.editMode) private var isEdit
    
    enum isRowFocus : Hashable {
        case subRoutine
        case rowID(id:UUID)
    }
    
    var body: some View {
        VStack{
            List(
                selection: $selectedRoutine
            ){ Section{
                ForEach($RoutineModel.list) { $item in
                    HStack{
                        TextField("Title", text: $item.title)
                            .focused($isFocus, equals: .rowID(id: item.id))
                            .font(.title3.bold())
                        
                        Button(action: {isSheet = true}){
                            Text("\(item.duration.toHourMin())")
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $isSheet){
                            RoutineDurationSheet(subRoutineDuration: $item)
                                .presentationDetents([.fraction(0.3)])
                                .presentationDragIndicator(.visible)
                        }
                    }
                    .listRowSeparator(.visible,edges: .bottom)
                }
                .onDelete(perform: deleteItem)
                .onMove(perform: self.moveItems)
                
            } footer: {
                HStack{
                    Button(action: addItem){
                        Image(systemName: "plus.circle.fill")
                            .padding(.top,5)
                    }
                    Spacer()
                }
                
            }
            }
            .listStyle(.insetGrouped)
            .scaledToFit()
        }
    }
    func deleteItem(at indexSet: IndexSet) {
        self.RoutineModel.list.remove(atOffsets: indexSet)
    }
    
    func addItem(){
        RoutineModel.addRow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {                            self.isFocus = .rowID(id: RoutineModel.list.last!.id)
        }
    }
    
    func moveItems(from indexSet: IndexSet, to destination: Int) {
        self.RoutineModel.list.move(fromOffsets: indexSet, toOffset: destination)
    }
}



struct RoutineMakerView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineMakerView()
            .environmentObject(RoutineViewModel())
    }
}

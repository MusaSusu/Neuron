//
//  DateCardRoutineView.swift
//  Neuron
//
//  Created by Alvin Wu on 2/6/23.
//

import SwiftUI

struct DateCardRoutineView: View {
    @ObservedObject var Routine : Routine
    @Environment(\.calendar) var calendar
    @Environment(\.timeZone) var timeZone
    
    var bounds: Range<Date> {
        let start = calendar.date(from: DateComponents(
            timeZone: timeZone, year: 2022, month: 6, day: 6))!
        let end = calendar.date(from: DateComponents(
            timeZone: timeZone, year: 2022, month: 6, day: 16))!
        return start ..< end
    }
    
    @State var dates: Set<DateComponents> = []
    
    var body: some View {
        MultiDatePicker("Dates Available", selection: $dates, in: bounds)
    }
}

struct DateCardRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        DateCardRoutineView(Routine: previewsRoutine)
    }
}

//
//  CalendarView.swift
//  BeautyScan
//
//  Created by Admin on 4/14/24.
//

import SwiftUI

struct CalendarView: View {
    @State var selectedDate: Date = Date()
    var didSelectDate: ((Date) -> Void)?
    
    var body: some View {
        VStack() {
            Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                .font(.system(size: 18))
                .bold()
                .foregroundColor(Color.black)
                .padding()
                .animation(.spring(), value: selectedDate)
                .frame(width: 370, height: 20)
                .scaledToFill()
            Divider().frame(height: 1)
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .padding(.horizontal)
                .tint(.purple)
                .foregroundStyle(.purple)
                .datePickerStyle(.graphical)
                .frame(width: 370, height: 283)
                .scaledToFill()
                .onChange(of: selectedDate, perform: { value in
                    didSelectDate?(value)
                })
            Divider()
        }
    }
}

#Preview {
    CalendarView()
}

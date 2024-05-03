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
                .font(.system(size: FontConstants.calendarFont))
                .bold()
                .foregroundColor(Color.black)
                .padding()
                .animation(.spring(), value: selectedDate)
                .frame(width: DesignConstants.frameWidth, height: DesignConstants.frameHeight)
                .scaledToFill()
            Divider().frame(height: 1)
            DatePicker(LocalizationKeys.selectDate.localized(), selection: $selectedDate, displayedComponents: [.date])
                .padding(.horizontal)
                .tint(.purple)
                .foregroundStyle(.purple)
                .datePickerStyle(.graphical)
                .frame(width: DesignConstants.frameWidth, height: DesignConstants.calendarHeight)
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

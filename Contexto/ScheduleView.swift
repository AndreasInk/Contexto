//
//  ScheduleView.swift
//  Contexto
//
//  Created by Andreas Ink on 4/26/22.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var noti: Noti
    @Binding var currentNoti: NotiData
    var body: some View {
        VStack {
            Section("Notification Frequency") {
            Stepper("Hour Betwween Notification") {
                currentNoti.hourIncrement += 1
            } onDecrement: {
                currentNoti.hourIncrement -= 1
            }
            }
           

        } .onDisappear() {
            if let index = noti.noti.firstIndex(where: { not in
                return not.id ?? "" == currentNoti.id
            }) {
            noti.noti[index] = currentNoti
        }
        
    }
}
}


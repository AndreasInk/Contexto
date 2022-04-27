//
//  EditNotiView.swift
//  Contexto
//
//  Created by Andreas Ink on 4/26/22.
//

import SwiftUI

struct EditNotiView: View {
    @ObservedObject var noti: Noti
    @Binding var currentNoti: NotiData
    var body: some View {
        
        List {
        ScheduleView(noti: noti, currentNoti: $currentNoti)
            Section("Noti Title") {
                TextField("Noti Title", text: $currentNoti.title)
            }
            Section("Noti Exempt Time") {
                DatePicker("Noti Exempt Start Time", selection: $currentNoti.from, displayedComponents: [.hourAndMinute])
                
                DatePicker("Noti Exempt End Time", selection: $currentNoti.to, displayedComponents: [.hourAndMinute])
            }
            
        }  .font(.system(.subheadline, design: .rounded))
    }
}


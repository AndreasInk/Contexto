//
//  ContentView.swift
//  Contexto
//
//  Created by Andreas Ink on 4/25/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var currentNoti: NotiData
    @ObservedObject var noti: Noti
    @State var edit = false
    var body: some View {
        
        VStack {
            Text("Latest Log")
                .font(.system(.title3, design: .rounded))
            Text(currentNoti.title)
                .font(.system(.title2, design: .rounded))
                .padding(.vertical)
            if let last = currentNoti.ratings.last {
                Text(last.category)
                    .font(.system(.largeTitle, design: .rounded)).bold()
                .padding(.bottom)
            } else {
                Text("No Ratings")
                    .font(.system(.title, design: .rounded)).bold()
            }
            GraphView(noti: noti, currentNoti: $currentNoti)
            .padding()
            .onAppear() {
                var i = 0
                for unit in Date.dates(from: Date(), to: Date().addingTimeInterval(604800), interval: currentNoti.hourIncrement) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(i)) {
                       
                    noti.createNoti(currentNoti, at: Date().distance(to: unit))
                    }
                    i += 1
                }
            }
            .sheet(isPresented: $edit) {
                EditNotiView(noti: noti, currentNoti: $currentNoti)
            }
        }
         .toolbar {
             ToolbarItem(placement: .navigationBarTrailing) {
                 Button {
                     edit = true
                 } label: {
                     Image(systemName: "pencil")
                         .symbolVariant(.circle)
                 }

             }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    noti.showShare = true
                } label: {
                    Image(systemName: "arrow.up")
                        .symbolVariant(.square)
                }

            }
        } .sheet(isPresented: $noti.showShare) {
            ShareSheet(activityItems: [noti.getDocumentsDirectory()])
        } 
        
    }
}


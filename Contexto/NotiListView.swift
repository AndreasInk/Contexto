//
//  NotiListView.swift
//  Contexto
//
//  Created by Andreas Ink on 4/26/22.
//

import SwiftUI

struct NotiListView: View {
    @StateObject var noti = Noti()
   
    @State var newNoti: NotiData?
    var body: some View {
        ZStack {
       
                
             
                   
               
        List {
            ForEach($noti.noti, id: \.id) { $noti in
                
                NavigationLink {
                    ContentView(currentNoti: $noti, noti: self.noti)
                } label: {
                 
                Text(noti.title)
                    .font(.system(.headline, design: .rounded))
                } .swipeActions {
//                    Button {
//                        newNoti = $noti.wrappedValue
//                    } label: {
//                        Image(systemName: "pencil")
//                    }

                    Button(role: ButtonRole.destructive) {
                        noti = NotiData()
                    } label: {
                        Image(systemName: "trash")
                    }

                }
               
               
               
            }
            
        } .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.noti.noti.append(NotiData())
                   
                } label: {
                    Image(systemName: "plus")
                        .symbolVariant(.circle)
                }
            }
        }
    }
}
}

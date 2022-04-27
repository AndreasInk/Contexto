//
//  ContextoApp.swift
//  Contexto
//
//  Created by Andreas Ink on 4/25/22.
//

import SwiftUI

@main
struct ContextoApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
            NotiListView()
            }
        }
    }
}

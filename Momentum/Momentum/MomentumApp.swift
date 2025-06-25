//
//  MomentumApp.swift
//  Momentum
//
//  Created by Joel Kim on 6/25/25.
//

import SwiftUI

@main
struct MomentumApp: App {
    
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authViewModel)
        }
    }
}

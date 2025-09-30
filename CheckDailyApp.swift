//
//  CheckDailyApp.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 23.09.2025.
//

import SwiftUI

@main
struct CheckDailyApp: App {
    @StateObject private var authModel = AuthStorage()

    var body: some Scene {
        WindowGroup {
            AuthRootView()
                .environmentObject(authModel)
        }
    }
}

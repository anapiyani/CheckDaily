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
    @StateObject private var checksVM = checksViewModel(checks: [])

    var body: some Scene {
        WindowGroup {
            AuthRootView()
                .environmentObject(authModel)
                .environmentObject(checksVM)
        }
    }
}

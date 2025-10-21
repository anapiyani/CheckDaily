//
//  RootView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 30.09.2025.
//

import SwiftUI

struct AuthRootView: View {
    @EnvironmentObject var authModel: AuthStorage
    
    var body: some View {
        Group {
            NavigationStack {
                if authModel.isLoggedIn {
                    WelcomeView()
                } else {
                    CheckDailyAuthView()
                }
            }
        }
    }
}


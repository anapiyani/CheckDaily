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
            if authModel.isLoggedIn {
                Text("Welcome to CheckDaily")
                Button("logout") {
                    authModel.isLoggedIn = false
                }
            } else {
                CheckDailyAuthView()
            }
        }
        .environmentObject(authModel)
    }
}


#Preview {
    AuthRootView().environmentObject(AuthStorage())
}

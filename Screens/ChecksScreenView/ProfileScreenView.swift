//
//  ProfileScreenView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 02.10.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authModel: AuthStorage
    
    var body: some View {
        Text("ProfileScreenView")
        TButton(text: "Sign out", action: {
            authModel.isLoggedIn = false
        })
    }
}

//
//  ChecksScreenView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//

import SwiftUI

struct ChecksScreenView: View {
    @StateObject var authModel = AuthStorage()
    
    var body: some View {
        if authModel.isLoggedIn {
            ZStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("ChecksScreenView")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        } else {
            CheckDailyAuthView()
        }
    }
}

#Preview {
    ChecksScreenView()
}
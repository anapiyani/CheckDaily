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
        NavigationView {
            VStack(spacing: 24) {
                

                VStack(spacing: 8) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.black.opacity(0.9))
                        .padding(.bottom, 8)
                    
                    Text(authModel.username)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(authModel.email)
                        .font(.subheadline)
                        .foregroundColor(Color("secondary-text"))
                }
                .padding(.top, 20)
                
                
                // MARK: - SETTINGS SECTION
                VStack(spacing: 0) {
                    ProfileRow(icon: "faceid", title: "Biometric Login") {
                        // Optional: show if token exists
                    }
                    
                    Divider().padding(.leading, 52)
                    
                    ProfileRow(icon: "key.fill", title: "Reset Biometrics") {
                        KeychainService.delete(key: "auth_token")
                    }
                    
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
                .padding(.horizontal)
                
                
                Spacer()
                
                TButton(
                    colors: .red,
                    isFilled: true,
                    text: "Sign Out",
                    action: {
                        KeychainService.delete(key: "auth_token")
                        authModel.username = ""
                        authModel.email = ""
                        authModel.token = nil
                        authModel.isLoggedIn = false
                    }
                )
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationTitle("Profile")
        }
    }
}


///Reusable row with icon + title
struct ProfileRow: View {
    var icon: String
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .frame(width: 28, height: 28)
                    .foregroundColor(.black)
                
                Text(title)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            .padding()
        }
    }
}

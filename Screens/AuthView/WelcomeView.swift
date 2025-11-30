//
//  Welcome.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 01.10.2025.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authModel: AuthStorage
    @StateObject private var vm = SignInViewModel()
    @State private var animateRotation: Bool = false

    @State private var isBiometricUnlocked: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                HStack {
                    TIconView()
                        .frame(width: 64, height: 64)
                        .overlay(alignment: .topTrailing) {
                            Image(systemName: "sparkle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.yellow)
                                .rotationEffect(.degrees(animateRotation ? 360 : 0))
                                .animation(.linear(duration: 2).repeatForever(autoreverses: false),
                                           value: animateRotation)
                                .onAppear { animateRotation = true }
                        }
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                VStack {
                    Text("Welcome back,")
                        .font(.title)
                        .foregroundColor(Color("secondary-text"))
                    Text(authModel.username)
                        .font(.title2)
                        .padding(.bottom, 20)
                        .padding(.top, 4)
                    Text("Ready to build some amazing habits?")
                        .font(.headline)
                        .foregroundColor(Color("secondary-text"))
                }
                if isBiometricUnlocked == true {
                    TNavigationButton(
                        colors: .black,
                        isFilled: true,
                        image: "arrow.right",
                        text: "Get started",
                        imagePlacement: "right",
                        destination: ChecksRootView().navigationBarBackButtonHidden(true)
                    )
                    .padding(.bottom, 40)
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
                }
                if isBiometricUnlocked == false {
                    if KeychainService.load(key: "auth_token") != nil {
                        TButton(
                            isFilled: false,
                            image: "touchid",
                            text: "Use Biometrics",
                            action: {
                                vm.biometricLogin(auth: authModel)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if authModel.isLoggedIn {
                                        isBiometricUnlocked = true
                                    }
                                }
                            }
                        )
                        .padding(.bottom, 40)
                        .padding(.top, 40)
                        .padding(.horizontal, 30)
                    }
                }
            }
        }
    }
}

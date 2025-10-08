//
//  Welcome.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 01.10.2025.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authModel: AuthStorage
    
    @State private var animateRotation: Bool = false

    
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
            }
        }
    }
}

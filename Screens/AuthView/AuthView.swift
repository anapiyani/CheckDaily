//
//  ContentView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 23.09.2025.
//

import SwiftUI

struct CheckDailyAuthView: View {
    @EnvironmentObject var authModel: AuthStorage
    @StateObject private var vm = SignInViewModel()
    
    @State var createAccountPopoverPresented: Bool = false
    
    var body: some View {
        VStack (spacing: 30) {
            VStack (spacing: 8) {
                TIconView()
                    .padding()
                Text("Tasks")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Text("Build habits, track progress")
                    .foregroundColor(Color("secondary-text"))
            }
            VStack {
                InputField(placeholder: "Email", textvalue: $vm.email)
                InputField(isPassword: true, placeholder: "Password", textvalue: $vm.password)
            }
            VStack (spacing: 12) {
                TButton(
                    isFilled: true,
                    text: "Continue",
                    action: {
                        if vm.signIn() {
                            vm.errorMessage = nil
                            authModel.isLoggedIn = true
                            print("Auth model is logged in saved", authModel.isLoggedIn)
                        }
                    }
                )
                Text("or")
                    .font(.callout)
                    .foregroundColor(Color("secondary-text"))
                TButton(
                    isFilled: false, image: "touchid", text: "Use Biometrics"
                )
            }
            Button(action: {
                createAccountPopoverPresented = true
            }) {
                Text("Don't have an account? Sign up")
                    .font(.caption)
                    .foregroundColor(Color("secondary-text"))
            }
            .popover(isPresented: $createAccountPopoverPresented) {
                CreateAccountPopoverView(
                    onClose: {
                        createAccountPopoverPresented = false
                    }
                ).environmentObject(authModel)
            }
            if (vm.errorMessage != nil) {
                Text(vm.errorMessage ?? "")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

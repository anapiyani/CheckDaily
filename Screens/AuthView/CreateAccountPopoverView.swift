//
//  CreateAccountView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//

import SwiftUI

struct CreateAccountPopoverView: View {
    @EnvironmentObject var auth: AuthStorage
    @StateObject private var vm = SignUpViewModel()
    
    @State var repeatPassword: String = ""
    @State var showErrorToast: Bool = false
    @State var isLoading: Bool = false
    @State var isSignUpSuccess: Bool = false
    var onClose: (() -> Void)
    
    func submit() {
        guard vm.canSubmit(repeatPassword: repeatPassword) else {
            showErrorToast = true
            return
        }
        isLoading = true
        vm.createAndSaveUser()
        isSignUpSuccess = true
        onClose()
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    onClose()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            Spacer()
            VStack {
                InputField(placeholder: "Full name", textvalue: $vm.username)
                InputField(placeholder: "Email", isLowercase: true, textvalue: $vm.email)
                InputField(isPassword: true, placeholder: "Password", textvalue: $vm.password)
                InputField(isPassword: true, placeholder: "Repeat password", textvalue: $repeatPassword)
            }
            .padding()
            TButton(isFilled: true,
                    shouldDisable: !vm.canSubmit(repeatPassword: repeatPassword),
                    text: "Create account",
                    action: {
                        submit()
                    }
            )
            .padding()
            Spacer()
        }
    }
}

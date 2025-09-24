//
//  ContentView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 23.09.2025.
//

import SwiftUI

struct CheckDailyAuthView: View {
    @StateObject var authModel = authStorage()
    
    @State var email: String = ""
    @State var password: String = ""
    @FocusState var isFocused: Bool
    
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
                InputField(placeholder: "Email", textvalue: $email)
                InputField(isPassword: true, placeholder: "Password", textvalue: $password)
            }
            VStack (spacing: 12) {
                TButton(
                    isFilled: true, shouldDisable: email.isEmpty || password.isEmpty,
                    text: "Continue"
                )
                Text("or")
                    .font(.callout)
                    .foregroundColor(Color("secondary-text"))
                TButton(
                    isFilled: false, image: "touchid", text: "Use Biometrics"
                )
            }
        }
        .padding()
    }
}


#Preview {
    CheckDailyAuthView()
}

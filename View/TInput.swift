//
//  CheckDailyInputView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//
import SwiftUI

struct InputField: View {
    var isPassword: Bool? = false
    var placeholder: String?
    var isLowercase: Bool? = false
    
    @Binding var textvalue: String
    @State var showPassword: Bool = false
    
    var body: some View {
        if (isPassword ?? false) {
            HStack {
                if (showPassword) {
                    TextField(placeholder ?? "Password", text: $textvalue)
                } else {
                    SecureField(placeholder ?? "Password", text: $textvalue)
                }
                Button (action: {
                    showPassword.toggle()
                }) {
                    showPassword
                    ?
                    Image(systemName: "eye")
                        .foregroundStyle(Color("secondary-text"))
                    :
                    Image(systemName: "eye.slash")
                        .foregroundStyle(Color("secondary-text"))
                }
            }
            .self.modifier(InputStyles())
        } else {
            TextField(placeholder ?? "Text", text: $textvalue)
                .self.modifier(InputStyles())
                .textInputAutocapitalization(isLowercase ?? true ? .none : .sentences)
        }
    }
}


struct InputStyles: ViewModifier {
    @FocusState var isFocused: Bool
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .focused($isFocused)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color("secondary-text") : Color.clear, lineWidth: 2)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

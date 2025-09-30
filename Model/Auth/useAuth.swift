//
//  useAuth.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//

import SwiftUI


final class AuthStorage: ObservableObject {
    @Published var username: String
    @Published var email: String
    @Published var isLoggedIn: Bool {
        didSet { UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn") }
    }

    init() {
        self.username   = UserDefaults.standard.string(forKey: "username") ?? ""
        self.email      = UserDefaults.standard.string(forKey: "email") ?? ""
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}

final class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    
    @discardableResult
    func signIn() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.isEmpty
        else { return false }
        if email == UserDefaults.standard.string(forKey: "email") ?? "" &&
            password == UserDefaults.standard.string(forKey: "password") ?? "" {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            return true
        }
        errorMessage = "Неверный email или пароль"
        return false
    }
}

final class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?

    func canSubmit(repeatPassword: String) -> Bool {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.isEmpty,
              password == repeatPassword,
              email.contains("@")
        else { return false }
        return true
    }

    @discardableResult
    func createAndSaveUser() -> Bool {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.set(password, forKey: "password")
        return true
    }
}


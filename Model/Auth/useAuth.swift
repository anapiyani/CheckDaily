//
//  useAuth.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//

import SwiftUI

struct RegisterData: Codable {
    var username: String
    var email: String
    var password: String
}

struct User: Codable {
    var id: Int
    var username: String
    var email: String
}

struct RegisterResponse: Codable {
    var success: Bool
    var message: String
    var token: String
    var user: User
}

struct APIErrorResponse: Codable {
    var detail: [APIErrorDetail]
}

struct APIErrorDetail: Codable {
    var loc: [String]
    var msg: String
    var type: String
}

final class AuthStorage: ObservableObject {
    @Published var username: String
    @Published var email: String
    @Published var isLoggedIn: Bool {
        didSet { UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn") }
    }
    @Published var token: String?

    init() {
        self.username   = UserDefaults.standard.string(forKey: "username") ?? ""
        self.email      = UserDefaults.standard.string(forKey: "email") ?? ""
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        self.token      = nil
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
    
    func signOut() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
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

    func createAndSaveUser(auth: AuthStorage) {
        guard let url = URL(string: "http://192.168.0.109:8000/api/v1/auth/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData: [String: Any] = [
            "username": username,
            "email": email,
            "password": password
        ]
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: jsonData, options: [])
            request.httpBody = jsonBody
        } catch {
            print("JSON error:", error)
            return
        }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Request error", error)
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decodedSuccess = try JSONDecoder().decode(RegisterResponse.self, from: data)
                DispatchQueue.main.async {
                    auth.username = decodedSuccess.user.username
                    auth.email = decodedSuccess.user.email
                    auth.token = decodedSuccess.token
                    auth.isLoggedIn = true
                }
            } catch {
                do {
                    let decodedError = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                    print("API ERROR:", decodedError.detail.first?.msg ?? "Unknown error")
                } catch {
                    print("UNKNOWN RESPONSE:", String(data: data, encoding: .utf8) ?? "Invalid UTF8")
                }
            }
        }.resume()
    }
}

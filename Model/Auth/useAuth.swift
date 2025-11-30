//
//  useAuth.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//

import SwiftUI
import LocalAuthentication

struct RegisterData: Codable {
    var username: String
    var email: String
    var password: String
}

struct LoginData: Codable {
    var email: String
    var password: String
}

struct User: Codable {
    var id: Int
    var username: String
    var email: String
}

struct AuthResponse: Codable {
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
        
        if let tokenData = KeychainService.load(key: "auth_token"),
           let token = String(data: tokenData, encoding: .utf8) {
            
            self.token = token
            self.isLoggedIn = true
        }
    }
}

final class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    
    func signIn(auth: AuthStorage, completion: @escaping (Bool) -> Void) {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.isEmpty
        else {
            completion(false)
            return
        }
        
        guard let url = URL(string: "http://192.168.0.109:8000/api/v1/auth/login") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonData: [String: Any] = [
            "email": email,
            "password": password
        ]

        do { request.httpBody = try JSONSerialization.data(withJSONObject: jsonData) }
        catch {
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Request error", error)
                DispatchQueue.main.async { completion(false) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(false) }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(AuthResponse.self, from: data)
                DispatchQueue.main.async {
                    auth.username = decoded.user.username
                    auth.email = decoded.user.email
                    auth.token = decoded.token
                    auth.isLoggedIn = true

                    KeychainService.save(key: "auth_token", data: Data(decoded.token.utf8))
                    self.errorMessage = nil
                    completion(true)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Неверный email или пароль"
                    completion(false)
                }
            }

        }.resume()
    }
    
    func biometricLogin(auth: AuthStorage) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Use Face ID to login"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        if let tokenData = KeychainService.load(key: "auth_token"),
                           let token = String(data: tokenData, encoding: .utf8) {

                            auth.token = token
                            auth.isLoggedIn = true
                        }
                    } else {
                        self.errorMessage = "Authentication failed"
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "Biometrics unavailable"
            }
        }
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
                let decodedSuccess = try JSONDecoder().decode(AuthResponse.self, from: data)
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

//
//  useAuth.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//

import SwiftUI


final class authStorage: ObservableObject {
    @Published var username = UserDefaults.standard.string(forKey: "username") ?? ""
    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    
}

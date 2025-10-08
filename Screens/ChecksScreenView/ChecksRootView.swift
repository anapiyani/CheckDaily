//
//  ChecksScreenView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//

import SwiftUI

struct ChecksRootView: View {
    @StateObject var authModel = AuthStorage()
    
    var body: some View {
        NavigationStack {
            VStack {
                ChecksMainView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Tasks")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink(destination: CreateView()) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 10)
                }
            }
            .onAppear {
                let ap = UINavigationBarAppearance()
                ap.configureWithOpaqueBackground()
                ap.backgroundColor = .systemBackground
                UINavigationBar.appearance().standardAppearance = ap
                UINavigationBar.appearance().scrollEdgeAppearance = ap
            }
        }
    }
}

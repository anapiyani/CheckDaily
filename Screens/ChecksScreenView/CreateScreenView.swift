//
//  TasksView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 02.10.2025.
//

import SwiftUI

struct CreateView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                CreateMainView()
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    TNavigationButton(
                        isFilled: false,
                        image: "arrow.backward",
                        text: "",
                        destination: ChecksRootView().navigationBarBackButtonHidden(true)
                    ).padding(.leading)
                    Text("New Task")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "plus.circle")
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

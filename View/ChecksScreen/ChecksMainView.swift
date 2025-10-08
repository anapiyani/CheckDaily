//
//  ChecksMainView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 09.10.2025.
//

import SwiftUI

struct ChecksMainView: View {
    var body: some View {
        NavigationStack {
            VStack (spacing: 20) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("secondary-text"))
                    .padding(24)
                    .background(
                      RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.gray.opacity(0.1))
                    )
                Text("No tasks yet")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Text("Create your first habit to start tracking your progress")
                    .font(.title3)
                    .foregroundColor(Color("secondary-text"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 15)
                TNavigationButton(
                    colors: .black,
                    isFilled: true,
                    text: "Create Task",
                    destination: CreateView().navigationBarBackButtonHidden(true)
                )
                .frame(width: 160, height: 50)
            }
            .padding()
            .padding(.top, 60)
            Spacer()
        }
    }
}

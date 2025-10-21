//
//  Preview.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 22.10.2025.
//

import SwiftUI

struct PreviewChecksView: View {
    @Binding var name: String
    let count: Int
    private var itemCount: Int { min(count, 30) }
    
    let columns = [GridItem(.adaptive(minimum: 24), spacing: 12)]

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(systemName: "target")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                }
                .padding(8)
                .background(Color(.systemGray2).opacity(0.2))
                .cornerRadius(18)
                Text(name.isEmpty ? "Your task name" : name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(0..<itemCount, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 24, height: 24)
                        .redacted(reason: .placeholder)
                }
            }
            .padding()
            if (count > 30) {
                Text("+\(count - 30) more days")
                    .font(.caption)
                    .foregroundStyle(Color("secondary-text"))
            }
            Text("\(count) days total • Track daily progress")
                .font(.caption)
                .foregroundStyle(Color("secondary-text"))
                .padding(.top, 5)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 240)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 5)
        )
    }
}

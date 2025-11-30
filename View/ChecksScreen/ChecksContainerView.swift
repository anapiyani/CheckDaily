//
//  ChecksContainerView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 23.10.2025.
//

import SwiftUI
struct ChecksContainerView: View {
    var id: UUID
    @EnvironmentObject var vm: checksViewModel
    
    private var checkData: durations? {
        vm[id: id]
    }

    private var itemCount: Int {
        min(checkData?.count ?? 0, 30)
    }
    
    let columns = [GridItem(.adaptive(minimum: 24), spacing: 12)]

    var body: some View {
        Group {
            if let check = checkData {
                content(for: check)
            } else {
                placeholder
            }
        }
    }

    private func content(for check: durations) -> some View {
        VStack(spacing: 14) {
            HStack {
                Text(check.name)
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(check.passedDays) of \(check.count) days")
                    Spacer()
                    Text("\(check.percentage)%")
                }
                ProgressView(value: Double(check.percentage), total: 100)
            }
            .padding(.bottom, 10)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(check.days.prefix(30)) { day in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(day.isChecked ?? false ? .green.opacity(0.9) : .gray.opacity(0.3))
                        .frame(width: 18, height: 18)
                }
            }

            if check.count > 30 {
                Text("+\(check.count - 30) more days")
                    .font(.caption)
                    .foregroundColor(Color("secondary-text"))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 250)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
        )
    }

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.gray.opacity(0.1))
            .frame(height: 120)
            .overlay(
                ProgressView()
            )
    }
}

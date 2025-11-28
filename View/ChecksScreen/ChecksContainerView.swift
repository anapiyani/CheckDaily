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
    private var checkData: durations {
        vm[id: id]!
    }
    var count: Int {checkData.count}
    var name: String {checkData.name}
    var days: [DayStatus] {checkData.days}
    var createdAt: Date {checkData.createdAt}
    var passedDays: Int {checkData.passedDays}
    var percentage: Int {checkData.percentage}
    
    private var itemCount: Int { min(count, 30) }
    let columns = [GridItem(.adaptive(minimum: 24), spacing: 12)]
    
    var body: some View {
        VStack (spacing: 14) {
            HStack {
                Text(name)
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 10)
            VStack(alignment: .leading) {
                HStack {
                    Text("\(passedDays) of \(count) days")
                    Spacer()
                    Text("\(Double(percentage).rounded(.down).description + "%")")
                }
                VStack {
                    ProgressView(value: Double(percentage), total: 100.0)
                }
            }
            .padding(.bottom, 10)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(days) { day in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(day.isChecked! ? Color.green.opacity(0.9) : Color.gray.opacity(0.3))
                        .frame(width: 18, height: 18)
                        .redacted(reason: .placeholder)
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 250)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 5)
        )
    }
}

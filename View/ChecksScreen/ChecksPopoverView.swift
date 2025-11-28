//
//  ChecksPopoverView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 28.11.2025.
//
import SwiftUI

struct ChecksPopoverView: View {
    @EnvironmentObject var vm: checksViewModel
    var checkID: UUID
    var onDismiss: () -> Void
    
    var check: durations {
        vm[id: checkID]!
    }
    
    let columns = [GridItem(.adaptive(minimum: 24), spacing: 12)]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Image(systemName: "target")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                    .background(.linearGradient(colors: [Color(.systemGray2), Color(.gray)], startPoint: .bottom, endPoint: .top))
                    .cornerRadius(18)
                    Text("\(check.name)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.black)
                        .padding()
                        .onTapGesture {
                            onDismiss()
                        }
                }
                .padding(.horizontal)
                .padding(.top)
                HStack {
                    Badge(text: "\(check.percentage)% Complete", color: .green, textColor: .green)
                        .padding(.horizontal, 14)
                    Badge(text: "\(check.passedDays)/\(check.count) days", color: .blue500, textColor: .blue)
                    Spacer()
                }
                .padding(.bottom)
                Divider()
            }
        }
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                   ForEach(check.days) { day in
                       DayBox(day: day)
                   }
            }
        }
        .padding()
        TButton(
            colors: .emerald,
            image: "checkmark.circle",
            text: "Done For Today",
            action: {vm.checkToday(for: check.id)},
            imagePlacement: "right"
        )
        .padding()
        Spacer()
    }
}


struct DayBox: View {
    let day: DayStatus
    
    private var shortDate: String {
        let df = DateFormatter()
        df.dateFormat = "MMM d"
        return df.string(from: day.date)
    }
    
    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 6)
                .fill(day.isChecked == true ? Color.green.opacity(0.7) : Color.gray.opacity(0.3))
                .frame(width: 24, height: 24)
            Text(shortDate)
                .font(.caption2)
                .foregroundColor(.black.opacity(0.6))
                .multilineTextAlignment(.center)
        }
    }
}

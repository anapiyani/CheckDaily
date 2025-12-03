//
//  ChecksPopoverView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 28.11.2025.
//
import SwiftUI

struct ChecksPopoverView: View {
    @EnvironmentObject var auth: AuthStorage
    let checkID: String
    @EnvironmentObject var vm: checksViewModel
    
    @State private var check: durations? = nil
    @State private var openSettings: Bool = false
    var onDismiss: () -> Void
    
    let columns = [GridItem(.adaptive(minimum: 24), spacing: 12)]
    
    var body: some View {
        Group {
            if let c = check {
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
                            Text("\(c.name)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                            Spacer()
                            Image(systemName: "gear")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                                .onTapGesture {
                                    openSettings = true
                                }
                                .confirmationDialog("Dialog", isPresented: $openSettings) {
                                    Button("Delete") {
                                        guard let token = auth.token else { return }
                                        vm.delete(apiID: c.apiID, token: token) { something in
                                            print("deleted")
                                        }
                                    }
                                        .buttonStyle(PlainButtonStyle())
                                        .foregroundColor(.red)
                                        .padding()
                                } message: {}
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
                            Badge(text: "\(c.percentage)% Complete", color: .green, textColor: .green)
                                .padding(.horizontal, 14)
                            Badge(text: "\(c.passedDays)/\(c.count) days", color: .blue500, textColor: .blue)
                            Spacer()
                        }
                        .padding(.bottom)
                        Divider()
                    }
                }
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(c.days) { day in
                            DayBox(day: day)
                        }
                    }
                }
                .padding()
                TButton(
                    colors: .emerald,
                    image: "checkmark.circle",
                    text: "Done For Today",
                    action: {
                        guard let token = auth.token else { return }
                        vm.doneToday(apiID: c.apiID, token: token) { updatedCheck in
                            DispatchQueue.main.async {
                                if let updatedCheck {
                                    vm.update(updatedCheck, done: true)
                                    check = updatedCheck
                                }
                            }
                        }
                    },
                    imagePlacement: "right"
                )
                .padding()
                Spacer()
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            if let token = auth.token {
                vm.fetchDetail(for: checkID, token: token) { result in
                    DispatchQueue.main.async {
                        self.check = result
                    }
                }
            }
        }
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

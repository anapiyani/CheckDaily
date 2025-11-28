//
//  Checks.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 22.10.2025.
//

import Foundation
import SwiftUI

struct DayStatus: Identifiable, Equatable {
    let id: UUID = UUID()
    let date: Date
    var isChecked: Bool? = false
    var checkedAt: Date? = nil
}

struct durations: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var count: Int
    var createdAt: Date
    var days: [DayStatus]
    var passedDays: Int
    var percentage: Int
    
    init(name: String, count: Int, createdAt: Date = Date()) {
            let safeCount = max(0, count)
            let start = Calendar.current.startOfDay(for: createdAt)
            let builtDays: [DayStatus] = (0..<safeCount).map { i in
                let d = Calendar.current.date(byAdding: .day, value: i, to: start) ?? start
                return DayStatus(date: Calendar.current.startOfDay(for: d))
            }

            self.name = name
            self.count = safeCount
            self.createdAt = start
            self.passedDays = Calendar.current.dateComponents([.day], from: self.createdAt, to: Date()).day ?? 0
            self.percentage = Int(Double(passedDays) / Double(count) * 100)
            self.days = builtDays
        }
    
    mutating func checkToday() {
        let today = Calendar.current.startOfDay(for: Date())
        
        if let index = days.firstIndex(where: { $0.date == today }) {
            days[index].isChecked = true
            days[index].checkedAt = Date()
        } else {
            let newDay = DayStatus(date: today, isChecked: true, checkedAt: Date())
            days.append(newDay)
            count = days.count
        }
    }
    
    mutating func recalcStats() {
        let checkedCount = days.filter { $0.isChecked == true }.count
        self.passedDays = Calendar.current.dateComponents([.day], from: createdAt, to: Date()).day ?? 0
        self.percentage = count == 0 ? 0 : Int(Double(checkedCount) / Double(count) * 100)
    }
}

final class checksViewModel: ObservableObject {
    /// Published property: when this array changes,
    /// all SwiftUI views observing it will re-render automatically.
    /// `private(set)` = read-only from outside, only this class can modify it.
    @Published private(set) var checks: [durations]
    
    init(checks: [durations]) {
        self.checks = checks
    }
    
    var isEmpty: Bool {checks.isEmpty}
    var count: Int {checks.count}
    
    /// Quick lookup by UUID (returns an optional result).
    /// Lets you write: `viewModel[id: someUUID]`
    subscript(id id: UUID) -> durations? {
        checks.first(where: { $0.id == id })
    }
    
    func add(_ check: durations) {
        guard !checks.contains(where: { $0.id == check.id }) else {
            return
        }
        checks.append(check)
        print(checks)
    }
    
    func update(_ check: durations) {
        if let index = checks.firstIndex(where: {$0.id == check.id}) {
            checks[index] = check
        } else {
            checks.append(check)
        }
    }
    
    func remove(_ id: UUID) {
        checks.removeAll { $0.id == id }
    }
    
    func checkToday(for id: UUID) {
        guard let index = checks.firstIndex(where: { $0.id == id }) else { return }
        
        var updated = checks[index]
        updated.checkToday()
        updated.recalcStats()
        updated.passedDays += 1
        checks[index] = updated
    }
    
    func removeAll() {
        checks.removeAll()
    }
}

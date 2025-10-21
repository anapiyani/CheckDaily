//
//  Checks.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 22.10.2025.
//

import Foundation

struct durations: Identifiable {
    var id = UUID()
    var name: String
    var count: Int
    var created_at: Date
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
    
    func removeAll() {
        checks.removeAll()
    }
}

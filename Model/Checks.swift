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


struct APICheckDay: Codable, Identifiable {
    let id: String
    let date: String
    let is_checked: Bool
    let checked_at: String?
}

struct APICheckResponse: Codable, Identifiable {
    let id: String
    let name: String
    let count: Int
    let created_at: String
    let passed_days: Int
    let percentage: Int
    let days: [APICheckDay]
}

extension APICheckResponse {
    func toDurations() -> durations {
        func parse(_ s: String) -> Date {
            let fmt = DateFormatter()
            fmt.locale = Locale(identifier: "en_US_POSIX")
            fmt.timeZone = .current
            fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return fmt.date(from: s) ?? Date()
        }

        let created = parse(created_at)

        let mappedDays = days.map { api in
            DayStatus(
                date: parse(api.date),
                isChecked: api.is_checked,
                checkedAt: api.checked_at != nil ? parse(api.checked_at!) : nil
            )
        }

        return durations(
            apiID: self.id,
            fromAPI: name,
            count: count,
            createdAt: created,
            days: mappedDays,
            passedDays: passed_days,
            percentage: percentage
        )
    }
}

struct APIChecksList: Codable {
    let checks: [APICheckResponse]
}

struct durations: Identifiable, Equatable {
    var id = UUID()
    var apiID: String
    var name: String
    var count: Int
    var createdAt: Date
    var days: [DayStatus]
    var passedDays: Int
    var percentage: Int
    
    init(apiID: String,
         fromAPI name: String,
         count: Int,
         createdAt: Date,
         days: [DayStatus],
         passedDays: Int,
         percentage: Int)
    {
        self.id = UUID()
        self.apiID = apiID   
        self.name = name
        self.count = count
        self.createdAt = createdAt
        self.days = days
        self.passedDays = passedDays
        self.percentage = percentage
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
    
    static func add(name: String, count: Int, token: String, completion: @escaping (durations?) -> Void) {
        guard let url = URL(string: "https://checkdaily-backend-production.up.railway.app/api/v1/checks") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "name": name,
            "count": count
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Request error:", error)
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(APICheckResponse.self, from: data)
                let mapped = decoded.toDurations()
                completion(mapped)
            } catch {
                print("Decoding error:", error)
                print("Raw:", String(data: data, encoding: .utf8) ?? "")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchAll(token: String) {
        guard let url = URL(string: "https://checkdaily-backend-production.up.railway.app/api/v1/checks") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Fetch error:", error)
                return
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(APIChecksList.self, from: data)
                let mapped = decoded.checks.map { $0.toDurations() }

                DispatchQueue.main.async {
                    self.checks = mapped
                }
            } catch {
                print("Decoding error:", error)
                print("Raw response:", String(data: data, encoding: .utf8) ?? "no utf8")
            }
        }.resume()
    }
    
    func parseISO(_ s: String) -> Date {
        let f1 = ISO8601DateFormatter()
        f1.formatOptions = [.withInternetDateTime]

        if let d = f1.date(from: s) { return d }

        let f2 = ISO8601DateFormatter()
        f2.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        return f2.date(from: s) ?? Date()
    }
    
    func fetchDetail(for apiID: String, token: String, completion: @escaping (durations?) -> Void) {
        guard let url = URL(string: "https://checkdaily-backend-production.up.railway.app/api/v1/checks/\(apiID)") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Detail fetch error:", error)
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(APICheckResponse.self, from: data)
                let mapped = decoded.toDurations()
                completion(mapped)
            } catch {
                print("Decoding detail error:", error)
                print("RAW:", String(data: data, encoding: .utf8) ?? "")
                completion(nil)
            }

        }.resume()
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

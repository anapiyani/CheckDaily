//
//  MockData.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 21.10.2025.
//

import SwiftUI

struct durationOptions: Identifiable {
    var id = UUID()
    var image_name: String
    var duration: String
    var descr: String
    var duration_days: String
    var is_selected: Bool
    var count: Int
    var gradient_colors: [Color]
}

let DurationOptions: [durationOptions] = [
    durationOptions(
        image_name: "clock.fill",
        duration: "1 Week",
        descr: "Quick start",
        duration_days: "7 days",
        is_selected: false,
        count: 7,
        gradient_colors: [Color.cyan, Color.blue] // from-blue-500 to-cyan-500
    ),
    durationOptions(
        image_name: "target",
        duration: "30 Days",
        descr: "Build habits",
        duration_days: "30 days",
        is_selected: false,
        count: 30,
        gradient_colors: [Color.green, Color.mint] // from-emerald-500 to-green-500
    ),
    durationOptions(
        image_name: "calendar",
        duration: "90 Days",
        descr: "Transform yourself",
        duration_days: "90 days",
        is_selected: false,
        count: 90,
        gradient_colors: [Color.purple, Color.pink] // from-purple-500 to-pink-500
    ),
    durationOptions(
        image_name: "infinity",
        duration: "365 Days",
        descr: "Long term",
        duration_days: "365 days",
        is_selected: false,
        count: 365,
        gradient_colors: [Color.orange, Color.red] // from-orange-500 to-red-500
    )
]

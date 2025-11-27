//
//  Badge.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 28.11.2025.
//

import SwiftUI

struct Badge: View {
    var text: String
    var color: Color
    var textColor: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(textColor)
            .padding(6)
            .background(color.opacity(0.2), in: RoundedRectangle(cornerRadius: 5))
    }
}

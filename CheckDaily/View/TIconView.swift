//
//  TIconView.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 24.09.2025.
//

import SwiftUI

struct TIconView: View {
    @State private var bgScale: CGFloat = 0.7
        @State private var bgOpacity: Double = 0.0
        @State private var textScale: CGFloat = 0.7
        @State private var textOpacity: Double = 0.0
        @State private var textRotation: Double = 0.0

        var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 90, height: 90)
                    .cornerRadius(25)
                    .scaleEffect(bgScale)
                    .opacity(bgOpacity)
                    .shadow(radius: 8)

                Text("T")
                    .font(.system(size: 32, weight: .semibold, design: .default))
                    .foregroundColor(.white)
                    .scaleEffect(textScale)
                    .opacity(textOpacity)
                    .rotation3DEffect(.degrees(textRotation), axis: (x: 0, y: 1, z: 0))
            }
            .onAppear {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.75)) {
                    bgScale = 1.0
                    bgOpacity = 1.0
                }
                withAnimation(.spring(response: 0.45, dampingFraction: 0.75).delay(0.05)) {
                    textScale = 1.0
                    textOpacity = 1.0
                }
                withAnimation(.easeInOut(duration: 0.6).delay(0.05)) {
                    textRotation = 360
                }
            }
        }
}

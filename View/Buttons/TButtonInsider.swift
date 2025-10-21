//
//  TButtonInsider.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 02.10.2025.
//
import SwiftUI

struct TButtonInsider: View {
    var imagePlacement: String? = nil
    var image: String? = nil
    var text: String = "Continue"
    var body: some View {
        HStack(spacing: 8) {
            if imagePlacement == "left" {
                if let image {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 10)
                }
            }
            Text(text)
                .font(.body.weight(.semibold))
                .lineLimit(1)
            if imagePlacement == "right" {
                if let image {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(.leading, 10)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

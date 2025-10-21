import SwiftUI

struct ToastView: View {
    let text: String
    let systemImage: String?

    var body: some View {
        HStack(spacing: 8) {
            if let systemImage {
                Image(systemName: systemImage)
            }
            Text(text)
                .font(.subheadline).bold()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 8)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let text: String
    let systemImage: String?
    let duration: Double

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if isPresented {
                    ToastView(text: text, systemImage: systemImage)
                        .padding(.top, 16)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation { isPresented = false }
                            }
                        }
                }
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isPresented)
    }
}

extension View {
    func toast(
        isPresented: Binding<Bool>,
        text: String,
        systemImage: String? = "checkmark.circle.fill",
        duration: Double = 2.0
    ) -> some View {
        modifier(ToastModifier(
            isPresented: isPresented,
            text: text,
            systemImage: systemImage,
            duration: duration
        ))
    }
}

//
//  Toast.swift
//  CheckDaily
//
//  Created by Anapiya Nurkeldi on 30.09.2025.
//

import SwiftUI

public enum ToastStyle {
    case success, error, info, loading
}

public struct Toast {
    public var title: String
    public var subtitle: String?
    public var style: ToastStyle = .info
    public var duration: TimeInterval = 2.0      // ignored for .loading
    public var haptic: Bool = false

    public init(title: String,
                subtitle: String? = nil,
                style: ToastStyle = .info,
                duration: TimeInterval = 2.0,
                haptic: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.duration = duration
        self.haptic = haptic
    }
}

private struct ToastView: View {
    let toast: Toast

    private var bg: Color {
        switch toast.style {
        case .success: return Color.green.opacity(0.92)
        case .error:   return Color.red.opacity(0.92)
        case .info:    return Color.primary.opacity(0.92)
        case .loading: return Color.gray.opacity(0.92)
        }
    }
    private var icon: String? {
        switch toast.style {
        case .success: return "checkmark.circle.fill"
        case .error:   return "xmark.octagon.fill"
        case .info:    return "info.circle.fill"
        case .loading: return nil
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            if toast.style == .loading {
                ProgressView().progressViewStyle(.circular).tint(.white)
            } else if let icon {
                Image(systemName: icon).foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(toast.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                if let subtitle = toast.subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.9))
                        .lineLimit(2)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(bg)
                .shadow(radius: 12, y: 6)
        )
        .padding(.horizontal, 16)
        .accessibilityAddTraits(.isStaticText)
    }
}

private struct ToastPresenter: ViewModifier {
    @Binding var isPresented: Bool
    let toast: Toast
    let placement: Alignment
    let onDismiss: (() -> Void)?

    @State private var visible = false

    func body(content: Content) -> some View {
        ZStack(alignment: placement) {
            content
            if isPresented {
                ToastView(toast: toast)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        visible = true
                        if toast.haptic {
                            let gen = UINotificationFeedbackGenerator()
                            switch toast.style {
                            case .success: gen.notificationOccurred(.success)
                            case .error:   gen.notificationOccurred(.error)
                            case .info, .loading: gen.notificationOccurred(.warning)
                            }
                        }
                        // Auto-dismiss for non-loading styles
                        if toast.style != .loading {
                            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.9)) {
                                    isPresented = false
                                }
                                onDismiss?()
                            }
                        }
                    }
                    .padding(.top, 8)     // distance from top safe area if top-aligned
                    .padding(.bottom, 24) // if bottom-aligned
                    .padding(.horizontal, 8)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.9), value: isPresented)
    }
}

public extension View {
    /// Show a toast overlay.
    func toast(isPresented: Binding<Bool>,
               toast: Toast,
               placement: Alignment = .top,
               onDismiss: (() -> Void)? = nil) -> some View {
        self.modifier(ToastPresenter(isPresented: isPresented,
                                     toast: toast,
                                     placement: placement,
                                     onDismiss: onDismiss))
    }

    /// Convenience helpers
    func toastSuccess(isPresented: Binding<Bool>, _ title: String, subtitle: String? = nil, haptic: Bool = false, placement: Alignment = .top) -> some View {
        toast(isPresented: isPresented,
              toast: Toast(title: title, subtitle: subtitle, style: .success, haptic: haptic),
              placement: placement)
    }
    func toastError(isPresented: Binding<Bool>, _ title: String, subtitle: String? = nil, haptic: Bool = true, placement: Alignment = .top) -> some View {
        toast(isPresented: isPresented,
              toast: Toast(title: title, subtitle: subtitle, style: .error, haptic: haptic),
              placement: placement)
    }
    func toastLoading(isPresented: Binding<Bool>, _ title: String = "Loading...", placement: Alignment = .top) -> some View {
        toast(isPresented: isPresented,
              toast: Toast(title: title, style: .loading, duration: .infinity),
              placement: placement)
    }
}

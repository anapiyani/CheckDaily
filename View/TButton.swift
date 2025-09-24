import SwiftUI

struct TButton: View {
    var colors: Color? = .black
    var isFilled: Bool = false
    var image: String? = nil
    var shouldDisable: Bool = false
    var text: String = "Continue"
    var action: () -> Void = {}

    var body: some View {
        styled(
            Button(action: action) {
                HStack(spacing: 8) {
                    if let image {
                        Image(systemName: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                    }
                    Text(text)
                        .font(.body.weight(.semibold))
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
            },
            filled: isFilled
        )
        .buttonBorderShape(.roundedRectangle(radius: 15))
        .tint(colors ?? .black)
        .controlSize(.large)
        .disabled(shouldDisable)
    }
}


@ViewBuilder
func styled(_ view: some View, filled: Bool) -> some View {
    if filled {
        view.buttonStyle(.borderedProminent)
    } else {
        view.buttonStyle(.bordered)
    }
}

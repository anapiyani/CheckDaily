import SwiftUI

struct TButton: View {
    var colors: Color? = .black
    var isFilled: Bool = false
    var image: String? = nil
    var shouldDisable: Bool = false
    var text: String = "Continue"
    var action: () -> Void = {}
    var imagePlacement: String? = "left" 

    var body: some View {
        styled(
            Button(action: action) {
                TButtonInsider(
                    imagePlacement: imagePlacement,
                    image: image, text: text
                )
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

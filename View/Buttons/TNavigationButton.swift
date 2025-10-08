import SwiftUI

struct TNavigationButton<Destination: View>: View {
    var colors: Color? = .black
    var isFilled: Bool = false
    var image: String? = nil
    var shouldDisable: Bool = false
    var text: String = "Continue"
    var action: () -> Void = {}
    var imagePlacement: String? = "left"
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            TButtonInsider(imagePlacement: imagePlacement, image: image, text: text)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(isFilled ? (colors ?? .black) : .clear)
                .foregroundStyle(isFilled ? Color.white : (colors ?? .black))
                .overlay(
                    isFilled ? RoundedRectangle(cornerRadius: 15)
                        .stroke(colors ?? .black, lineWidth: isFilled ? 0 : 1) : nil
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .disabled(shouldDisable)
    }
}

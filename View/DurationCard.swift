import SwiftUI

struct DurationCard: View {
    var image_name: String = ""
    var duration: String = ""
    var descr: String = ""
    var duration_days: String = ""
    var is_selected: Bool = false
    var gradient_colors: [Color] = []
    
    var body: some View {
        HStack (spacing: 20) {
            VStack {
                Image(systemName: image_name)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            }
            .padding()
            .background(.linearGradient(colors: gradient_colors, startPoint: .bottom, endPoint: .top))
            .cornerRadius(18)
            VStack (alignment: .leading) {
                Text(duration)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(descr)
                    .foregroundColor(Color("secondary-text"))
                    .fontWeight(.light)
                    .font(.caption)
            }
            Spacer()
            VStack {
                Text(duration_days)
                    .foregroundColor(Color("secondary-text"))
                    .fontWeight(.light)
                    .font(.footnote)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, is_selected ? 14 : 10)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(is_selected ? Color("chosenBorder") : Color("border"), lineWidth: 1)
        )
        .scaleEffect(is_selected ? 1.05 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: is_selected)
    }
}




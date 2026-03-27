import SwiftUI


@available(iOS 13.0, *)
struct AffiseButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title) {
            action()
        }
        .buttonStyle(.plain)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 38 / 255, green: 34 / 255, blue: 58 / 255))
        )
    }
}

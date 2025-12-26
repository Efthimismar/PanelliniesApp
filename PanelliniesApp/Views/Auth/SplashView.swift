import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()

   
            Text("PanelliniesApp")
                .font(.largeTitle)
                .fontWeight(.bold)

            ProgressView()
                .progressViewStyle(.circular)

            Text("Φόρτωση…")
                .font(.footnote)
                .foregroundColor(.secondary)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    SplashView()
}

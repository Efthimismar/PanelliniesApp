import SwiftUI

struct WelcomeView: View {
    @State private var showLoginView = false
    @State private var showSignUpView = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Text group positioned higher
                VStack(spacing: 8) {
                    Text(NSLocalizedString("Καλώς Ήρθες στο PanelliniesApp", comment: "Welcome screen greeting"))
                        .font(.title).bold(true)
                    Text("Ο βοήθος σου για να πετύχεις στις πανελλήνιες")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .position(x: geo.size.width/2, y: geo.size.height * 0.15)

  
                VStack(spacing: 16) {
                    Button {
                        showLoginView = true
                    } label: {
                        Text(" Συνεδση ")
                            .font(.title2)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(14)
                    }
                    
                    Button {
                        showSignUpView = true
                    } label: {
                        Text(" Εγγραφη ")
                            .font(.title2)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(14)
                    }
                }
                .frame(maxWidth: .infinity)
                .position(x: geo.size.width/2, y: geo.size.height * 0.6)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .fullScreenCover(isPresented: $showLoginView) {
                LoginView()
            }
            .fullScreenCover(isPresented: $showSignUpView) {
                RegisterView()
            }
        }
    }
}
#Preview {
    WelcomeView()
}

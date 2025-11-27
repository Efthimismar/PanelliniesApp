import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Text("Login View")
    }
}
#Preview {
    LoginView()
}

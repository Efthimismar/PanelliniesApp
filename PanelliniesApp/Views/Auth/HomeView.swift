import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Logged in ✅")
                Button("Sign out") {
                    Task { await authVM.signOut() }
                }
                Text("Γεια σου, \(authVM.currentUser?.name ?? "—")")
            }
            .navigationTitle("Home")
            .padding()
        }
    }
}
#Preview {
    HomeView()
}

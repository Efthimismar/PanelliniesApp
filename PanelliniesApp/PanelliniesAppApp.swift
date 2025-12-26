import SwiftUI
import Firebase

@main
struct PanelliniesAppApp: App {
    @StateObject private var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
        }
    }
}

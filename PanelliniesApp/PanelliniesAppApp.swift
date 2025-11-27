
import SwiftUI
import Firebase

@main
struct PanelliniesAppApp: App {
    init() {
           FirebaseApp.configure()
       }
    var body: some Scene {
        WindowGroup {
            RegisterView()
        }
    }
}

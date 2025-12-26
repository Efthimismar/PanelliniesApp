import Combine
import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isBootstrapping = true

    private let authService: FirebaseAuthService

    init(authService: FirebaseAuthService? = nil) {
        self.authService = authService ?? FirebaseAuthService.shared
        Task { await bootstrapSession() }
    }

    func bootstrapSession() async {
        defer { isBootstrapping = false }

        guard let uid = authService.currentUID() else {
            currentUser = nil
            return
        }

        do {
            currentUser = try await authService.fetchUser(uid: uid)
        } catch {
            currentUser = nil
        }
    }

    func signUp(name: String, direction: Direction, email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            currentUser = try await authService.signUp(
                email: email,
                password: password,
                userName: name,
                direction: direction
            )
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            currentUser = try await authService.signIn(email: email, password: password)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            currentUser = nil
        }
    }

    func signOut() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            try authService.signOut()
            currentUser = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


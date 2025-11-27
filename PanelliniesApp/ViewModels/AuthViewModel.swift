import Combine
import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let authService  = FirebaseAuthService.shared
    func signUp(name: String , direction: Direction , email: String , password: String) async{
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let user  = try await authService.signUp(email: email, password: password, userName: name, direction: direction)
            currentUser = user
            
        }catch {
            errorMessage = error.localizedDescription
        }
    }
    func signIn(email: String , password: String) async{
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let user  = try await authService.signIn(email: email, password: password)
            currentUser = user
            
        }catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func signOut()async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            try authService.signOut()
            currentUser = nil
        }catch{
            errorMessage = error.localizedDescription
        }
    }
}


import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthErrorCodes: LocalizedError {
    case userNotFound
    case invalidPassword
    case userAlreadyExists
    case missingParameter
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "User not found"
        case .invalidPassword:
            return "Invalid password"
        case .userAlreadyExists:
            return "User already exists"
        case .missingParameter:
            return "Missing parameter"
        case .unknownError:
            return "Unknown error occurred"
        }
    }
}

final class FirebaseAuthService {
    static let shared = FirebaseAuthService()
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func signUp(email: String,
                password: String,
                userName: String,
                direction: Direction) async throws -> UserModel {
        
        guard !email.isEmpty, !password.isEmpty, !userName.isEmpty else {
            throw AuthErrorCodes.missingParameter
        }
        
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            let uid = result.user.uid
            
            let now = Date()
            let user = UserModel(
                id: uid,
                name: userName,
                email: email,
                direction: direction,
                createdAt: now,
                lastLogin: now
            )
            
            let encoded = try Firestore.Encoder().encode(user)
            try await db.collection("users").document(uid).setData(encoded)
            
            return user
        } catch let error as NSError {
            throw mapAuthError(error)
        }
    }
    
  
    func signIn(email: String, password: String) async throws -> UserModel {
        guard !email.isEmpty, !password.isEmpty else {
            throw AuthErrorCodes.missingParameter
        }
        
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            let uid = result.user.uid
            
            let snapshot = try await db.collection("users").document(uid).getDocument()
            guard let data = snapshot.data() else {
                throw AuthErrorCodes.userNotFound
            }
            
            let decoder = Firestore.Decoder()
            return try decoder.decode(UserModel.self, from: data)
        } catch let error as NSError {
            throw mapAuthError(error)
        }
    }
    
    func signOut() throws {
        try auth.signOut()
    }
    

    private func mapAuthError(_ error: NSError) -> AuthErrorCodes {
        guard error.domain == AuthErrorDomain, let code = AuthErrorCode(rawValue: error.code) else {
            return .unknownError
        }
        
        switch code {
        case .userNotFound:
            return .userNotFound
        case .wrongPassword:
            return .invalidPassword
        case .emailAlreadyInUse:
            return .userAlreadyExists
        case .missingEmail:
            return .missingParameter
        default:
            return .unknownError
        }
    }
}


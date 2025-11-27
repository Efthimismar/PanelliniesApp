import Foundation
import FirebaseFirestore

struct UserModel: Identifiable, Codable {
    var id: String          
    var name: String
    var email: String
    var direction: Direction
    var createdAt: Date
    var lastLogin: Date?
}

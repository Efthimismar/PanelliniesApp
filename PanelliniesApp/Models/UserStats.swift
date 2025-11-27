import Foundation

struct UserStats: Identifiable, Codable {
    var id: String
    var totalAnswered: Int
    var totalCorrect: Int
    var perSubject: [String: SubjectStats]
}

struct SubjectStats: Codable {
    var correct: Int
    var wrong: Int
}

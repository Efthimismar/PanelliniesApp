import Foundation

struct Question: Identifiable, Codable {
    
    var id: String
    var subjectId: String
    var chapterId: String
    var question: String
    var answers: [String]
    var correctAnswer: String
    var correctCount: Int
    var wrongCount: Int
    var difficulty: Int
    var timeToComplete: Int
}



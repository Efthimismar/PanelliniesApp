import Foundation

struct Subject: Identifiable, Codable {
    var id: String
    var name: String
    var direction: Direction
    var chapters: [Chapter]?    
    var coefficient: Double     // βαρύτητα μαθήματος
    
    enum CodingKeys: String, CodingKey {
        case id, name, direction, chapters, coefficient
    }
}

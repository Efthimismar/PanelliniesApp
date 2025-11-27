import Foundation

struct Subject: Identifiable, Codable {
    var id: String
    var name: String            // π.χ. "Φυσική"
    var direction: String       // π.χ. "Θετικών"
    var chapters: [Chapter]     // optional αν θες πιο granular data
}

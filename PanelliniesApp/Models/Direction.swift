import Foundation

enum Direction: String,CaseIterable,Codable , Identifiable{
    case humanities
    case health
    case science
    case economics
    
    var id: String{self.rawValue}
    
    var localizedName: String{
        switch self{
        case .humanities:
            return "direction.humanities".localized
        case .health:
            return "direction.health".localized
        case .science:
            return "direction.science".localized
        case .economics:
            return "direction.economics".localized
        }
    }
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

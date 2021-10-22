import Foundation

struct User: Codable {
    let id: ID
    var name: String
    var iconURL: URL
    
    struct ID: Hashable, RawRepresentable, Codable, CustomStringConvertible, ExpressibleByIntegerLiteral {
        let rawValue: Int
        init(rawValue: Int) {
            self.rawValue = rawValue
        }
        init(integerLiteral value: Int) {
            self.init(rawValue: value)
        }
        var description: String { rawValue.description }
    }
}

extension URL: @unchecked Sendable {}

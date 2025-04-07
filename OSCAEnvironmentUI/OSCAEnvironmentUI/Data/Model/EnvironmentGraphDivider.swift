import SwiftUI

open class EnvironmentGraphDivider: Codable {
    public var name: String
    public var value: Double
    public var color: String
    
    func getColor() -> Color {
        return Color(hex: color)
    }
}

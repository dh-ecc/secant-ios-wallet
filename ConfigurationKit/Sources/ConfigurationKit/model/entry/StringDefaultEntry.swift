import Foundation

public struct StringDefaultEntry: DefaultEntry {
    public typealias Value = String

    public let key: String

    public let defaultValue: Value

    public func value(configuration: Configuration?) -> Value {
        if let configuration = configuration {
            return configuration.getString(key: key, defaultValue: defaultValue)
        }

        return defaultValue
    }
}

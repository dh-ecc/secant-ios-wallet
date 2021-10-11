import Foundation

public struct IntDefaultEntry: DefaultEntry {
    public typealias Value = Int

    public let key: String

    public let defaultValue: Value

    public func value(configuration: Configuration?) -> Value {
        if let configuration = configuration {
            return configuration.getInt(key: key, defaultValue: defaultValue)
        }

        return defaultValue
    }
}

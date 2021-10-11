import Foundation

public struct BooleanDefaultEntry: DefaultEntry {
    public typealias Value = Bool

    public let key: String

    public let defaultValue: Value

    public init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public func value(configuration: Configuration?) -> Value {
        if let configuration = configuration {
            return configuration.getBool(key: key, defaultValue: defaultValue)
        }

        return defaultValue
    }
}

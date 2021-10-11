import Foundation

public struct DictionaryConfiguration: Configuration {

    private let _updatedAt: Date?
    private let map: [String: String]

    public init(updatedAt date: Date? = nil, dictionary: [String: String]) {
        _updatedAt = date
        map = dictionary
    }

    public func updatedAt() -> Date? {
        _updatedAt
    }

    public func has(key: String) -> Bool {
        nil != map[key]
    }

    public func getString(key: String, defaultValue: String) -> String {
        map[key] ?? defaultValue
    }

    public func getBool(key: String, defaultValue: Bool) -> Bool {
        if let value = map[key] as NSString? {
            return value.boolValue
        }

        return defaultValue
    }

    public func getInt(key: String, defaultValue: Int) -> Int {
        if let valueString = map[key] {
            if let valueInt = Int(valueString) {
                return valueInt
            }
        }

        return defaultValue
    }
}

public extension DictionaryConfiguration {
    static let empty = DictionaryConfiguration(dictionary: [String: String]())
}

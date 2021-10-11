import Foundation

struct MergingConfiguration: Configuration {

    let configurations: [Configuration]

    public func updatedAt() -> Date? {
        configurations
            .compactMap { elt in elt.updatedAt() }
            .max()
    }

    public func has(key: String) -> Bool {
        if nil != firstWithKey(key: key) {
            return true
        }

        return false
    }

    public func getString(key: String, defaultValue: String) -> String {
        if let configuration = firstWithKey(key: key) {
            return configuration.getString(key: key, defaultValue: defaultValue)
        }

        return defaultValue
    }

    public func getBool(key: String, defaultValue: Bool) -> Bool {
        if let configuration = firstWithKey(key: key) {
            return configuration.getBool(key: key, defaultValue: defaultValue)
        }

        return defaultValue
    }

    public func getInt(key: String, defaultValue: Int) -> Int {
        if let configuration = firstWithKey(key: key) {
            return configuration.getInt(key: key, defaultValue: defaultValue)
        }

        return defaultValue
    }

    private func firstWithKey(key: String) -> Configuration? {
        configurations.first { configuration in configuration.has(key: key) }
    }
}

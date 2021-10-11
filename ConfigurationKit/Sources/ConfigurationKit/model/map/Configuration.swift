import Foundation

public protocol Configuration {
    /**
     * Date when the configuration was updated. Nil indicates the configuration either doesn't refresh or has never been refreshed.
     */
    func updatedAt() -> Date?

    /**
     * Determines whether `key` exists in the configuration.
     */
    func has(key: String) -> Bool

    /**
     * Gets the value for `key` in the configuration.  If `key` doesn't exist or type coercion fails, returns `defaultValue`.
     */
    func getString(key: String, defaultValue: String) -> String

    /**
     * Gets the value for `key` in the configuration.  If `key` doesn't exist or type coercion fails, returns `defaultValue`.
     */
    func getBool(key: String, defaultValue: Bool) -> Bool

    /**
     * Gets the value for `key` in the configuration.  If `key` doesn't exist or type coercion fails, returns `defaultValue`.
     */
    func getInt(key: String, defaultValue: Int) -> Int
}

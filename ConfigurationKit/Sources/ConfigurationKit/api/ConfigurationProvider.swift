import Foundation
import Combine

public protocol ConfigurationProvider {

    /**
     * - Returns: Immutable snapshot of the configuration.  If the configuration is still loading,
     * the returned object will be an empty configuration.
     */
    func peekConfiguration() -> Configuration

    /**
     * - Returns: Publisher that emits a new configuration snapshot as soon as it changes.
     *  Initially emits null until the configuration is loaded.
     */
    func getConfigurationPublisher() -> AnyPublisher<Configuration?, Never>

    /**
     * Serves as a hint that it is a good time to refresh now.
     *
     * Use cases might include refreshing the config in the About window for troubleshooting, when a
     * failure occurs that might be disabled (like a security lockout), or when the app is performing
     * periodic background work that requires a network connection.
     */
    func hintToRefresh()
}

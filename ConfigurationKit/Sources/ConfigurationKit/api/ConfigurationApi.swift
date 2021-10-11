import Foundation

public class ConfigurationApi {
    public static let shared = ConfigurationApi()

    private let _provider: MultiConfigurationProvider
    public let provider: ConfigurationProvider

    private init() {
        let multiProvider = MultiConfigurationProvider()
        #if DEBUG
        multiProvider.addProvider(provider: UserDefaultsConfigurationProvider())
        #endif

        _provider = multiProvider
        provider = multiProvider
    }

    public func registerAdditional(configurationProvider: ConfigurationProvider) {
        _provider.addProvider(provider: configurationProvider)
    }
}

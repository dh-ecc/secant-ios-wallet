import Foundation
import Combine

public class MockConfigurationProvider: ConfigurationProvider {
    private let _configuration: Configuration

    public init() {
        _configuration = DictionaryConfiguration(dictionary: [String: String]())
    }

    public init(configuration: DictionaryConfiguration) {
        _configuration = configuration
    }

    public func peekConfiguration() -> Configuration {
        _configuration
    }

    public func getConfigurationPublisher() -> AnyPublisher<Configuration?, Never> {
        CurrentValueSubject<Configuration?, Never>(_configuration).eraseToAnyPublisher()
    }

    public func hintToRefresh() {
        // Do nothing
    }

}

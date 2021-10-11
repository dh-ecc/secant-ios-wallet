import Foundation
import Combine

class MultiConfigurationProvider: ConfigurationProvider {
    private var _providers = [ConfigurationProvider]()

    private var _publisher: AnyPublisher<Configuration?, Never> = CurrentValueSubject(nil).eraseToAnyPublisher()

    init() {
    }

    // Note that if providers are added after a client retrieves the publisher, the client won't be notified
    func addProvider(provider: ConfigurationProvider) {
        _providers.append(provider)

        _publisher = newConfigurationPublisher()
    }

    func peekConfiguration() -> Configuration {
        MergingConfiguration(configurations: _providers.map { provider in provider.peekConfiguration() })
    }

    func getConfigurationPublisher() -> AnyPublisher<Configuration?, Never> {
        _publisher
    }

    private func newConfigurationPublisher() -> AnyPublisher<Configuration?, Never> {
        let publishers = _providers.map { provider in provider.getConfigurationPublisher() }

        let publisher: AnyPublisher<Configuration?, Never>

        switch publishers.count {
        case 0:
            publisher = CurrentValueSubject<Configuration?, Never>(peekConfiguration()).eraseToAnyPublisher()
        case 1:
            publisher = publishers.first!
        case 2:
            publisher = publishers.first!.combineLatest(publishers[1]) { _, _ -> Configuration in
                self.peekConfiguration()
            }.eraseToAnyPublisher()
        case 3:
            publisher = publishers.first!.combineLatest(publishers[1], publishers[2]) { _, _, _ -> Configuration in
                self.peekConfiguration()
            }.eraseToAnyPublisher()
        case 4:
            publisher = publishers.first!.combineLatest(publishers[1], publishers[2], publishers[3]) { _, _, _, _ -> Configuration in
                self.peekConfiguration()
            }.eraseToAnyPublisher()
        default:
            fatalError("More than 4 configuration providers are not supported.")
        }

        return publisher
            .receive(on: DispatchQueue.main)
            .multicast { CurrentValueSubject<Configuration?, Never>(nil) }
            .autoconnect()
            .eraseToAnyPublisher()
    }

    func hintToRefresh() {
        _providers.forEach { provider in
            provider.hintToRefresh()
        }
    }
}

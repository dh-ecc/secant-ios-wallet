import Foundation
import Combine

/*
 * On macOS, this provides a quick hack to support pushing configuration values into
 * an app using Terminal commands.  How do we implement something similar on iOS?
 */
class UserDefaultsConfigurationProvider: ConfigurationProvider {
    private let userDefaults: UserDefaults = UserDefaults.standard

    func peekConfiguration() -> Configuration {
        let mapped = userDefaults.dictionaryRepresentation()
            .filter { _, value in value is String }
            .mapValues {elt in elt as! String}

        return DictionaryConfiguration(dictionary: mapped)
    }

    func getConfigurationPublisher() -> AnyPublisher<Configuration?, Never> {
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .mapToVoid()
            .kickstart()
            .receive(on: DispatchQueue.main)
            .map { _ in self.peekConfiguration() }
            .eraseToAnyPublisher()
    }

    func hintToRefresh() {

    }
}

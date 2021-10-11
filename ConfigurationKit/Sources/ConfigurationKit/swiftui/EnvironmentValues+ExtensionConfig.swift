import Foundation
import SwiftUI

public extension EnvironmentValues {
    var configurationProvider: ConfigurationProvider {
        get {
            return self[ConfigurationFetcherKey.self]
        }
        set {
            self[ConfigurationFetcherKey.self] = newValue
        }
    }
}

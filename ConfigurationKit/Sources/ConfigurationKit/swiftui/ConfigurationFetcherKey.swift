import Foundation
import SwiftUI

struct ConfigurationFetcherKey: EnvironmentKey {
    static let defaultValue: ConfigurationProvider = ConfigurationApi.shared.provider
}

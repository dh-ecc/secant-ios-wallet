# ConfigurationKit
Defines a set of interfaces to implement different remote config implementations.

Note that while this is being implemented in the iOS Wallet repository, this interface is intended to be generic and can be moved elsewhere later.

# Requirements
* Fail-safe defaults: If the configuration file cannot be retrieved or is corrupted, the app must continue to function with fail-safe defaults.
* Support dynamic updates: Clients should be able to decide whether to leverage new configuration values immediately, instead of being forced to wait until next app launch.
* Type safety: Clients should be able to extract potentially complex configuration entries, such as lists or even objects.
* Sanity checking: Clients should be able to assert bad configuration values and reject them.  For example, a client can validate an int being in a predefined range.
* Support for multiple implementations: Over time, different sources for remote config could be implemented.  In some cases, a client might use multiple sources simultaneously.  This approach enables simplified manual and automated testing, as well as easy migration to different remote config providers.

# Architecture
Initially loading configuration is necessarily a slow call, such as loading a cached configuration file from disk.  In addition, configuration could change at any time due to fetches to refresh configuration.  These characteristics suggest a reactive API would enable applications to implement remote configuration in a high performance and dynamic way.

At a high level, the important objects in the public API are:

 * `ConfigurationApi` - Implements the entrypoint for remote config.  Allows client applications to register custom implementations of `ConfigurationProvider`.
 * `ConfigurationProvider` - Provides a publisher to emits Configuration objects.
 * `Configuration` - Implements an immutable snapshot of key-value configuration entries.  This is a simple object, with getters for types like Boolean, String, and Integer.  Although getters exist on this object, applications do not typically use the Configuration object directly but rather pass it to a DefaultEntry to extract values.
 * `DefaultEntry` - Associates a key with a default value.  This design ensures that the same key always uses the same default value throughout an application.  Various subclasses of `DefaultEntry` allow for type safety and additional types not implemented by the `Configuration` object.


Example usage:

```
// App defines configuration entries.
public class MyConfigurationEntries {
    public static let isFeatureX = BooleanDefaultEntry(key: "is_feature_x", defaultValue: true)
}
```

```
// During AppDelegate initialization
ConfigurationApi.shared.registerAdditional(configurationProvider: MyCustomConfigurationProvider())
```

```
// Usage to observe configuration changes
val configurationPublisher = ConfigurationApi.shared.getConfigurationPublisher()
configurationPublisher.sink { configuration in
    if (MyConfigurationEntries.isFeatureX.get(configuration: configuration)) {
        // Do feature x
    }
}
```

```
// SwiftUI

@Environment(\.configurationProvider) var configurationProvider

@State
private var configuration: Configuration?

var body: some View {
    return HStack {
        if (MyConfigurationEntries.isFeatureX.get(configuration)) {
            // Do feature x
        }
    }.onReceive(configurationProvider.getConfigurationPublisher().compactMap { $0 }) { configuration in
        self.configuration = configuration
    }
}
```

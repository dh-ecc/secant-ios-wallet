import Foundation

public protocol DefaultEntry {
    associatedtype Value

    var key: String { get }

    var defaultValue: Value { get }

    /*
     * API design note: configuration is nullable to support SwiftUI.
     * This allows a nullable @State configuration var that can be assigned
     * through onReceive() on a view that grabs configurationProvider from
     * the Environment.
     */
    func value(configuration: Configuration?) -> Value

}

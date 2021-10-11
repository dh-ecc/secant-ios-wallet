import XCTest
@testable import ConfigurationKit

final class BooleanDefaultEntryTests: XCTestCase {
    func testGetValue_true() {
        let key = "k"
        let value = true

        let entry = BooleanDefaultEntry(key: key, defaultValue: !value)

        let actual = entry.value(configuration: DictionaryConfiguration(dictionary: [key: "\(value)"]))

        XCTAssertEqual(actual, value)
    }

    func testGetValue_false() {
        let key = "k"
        let value = false

        let entry = BooleanDefaultEntry(key: key, defaultValue: !value)

        let actual = entry.value(configuration: DictionaryConfiguration(dictionary: [key: "\(value)"]))

        XCTAssertEqual(actual, value)
    }

    func testGetValue_default() {
        let key = "k"
        let value = false

        let entry = BooleanDefaultEntry(key: key, defaultValue: !value)

        let actual = entry.value(configuration: DictionaryConfiguration(dictionary: [String: String]()))

        XCTAssertEqual(actual, !value)
    }

    static var allTests = [
        ("testGetValue_true", testGetValue_true),
        ("testGetValue_false", testGetValue_false),

        ("testGetValue_default", testGetValue_default)
    ]
}

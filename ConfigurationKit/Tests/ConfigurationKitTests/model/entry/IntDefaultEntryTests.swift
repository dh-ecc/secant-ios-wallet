import XCTest
@testable import ConfigurationKit

final class IntDefaultEntryTests: XCTestCase {
    func testGetValue() {
        let key = "k"
        let value = 5
        let defaultValue = 4

        let entry = IntDefaultEntry(key: key, defaultValue: defaultValue)

        let actual = entry.value(configuration: DictionaryConfiguration(dictionary: [key: "\(value)"]))

        XCTAssertEqual(actual, value)
    }

    func testGetValue_default() {
        let key = "k"
        let defaultValue = 4

        let entry = IntDefaultEntry(key: key, defaultValue: defaultValue)

        let actual = entry.value(configuration: DictionaryConfiguration(dictionary: [String: String]()))

        XCTAssertEqual(actual, defaultValue)
    }

    func testGetValue_default_coerce_fail() {
        let key = "k"
        let value = "five"
        let defaultValue = 4

        let entry = IntDefaultEntry(key: key, defaultValue: defaultValue)

        let actual = entry.value(configuration: DictionaryConfiguration(dictionary: [key: value]))

        XCTAssertEqual(actual, defaultValue)
    }

    static var allTests = [
        ("testGetValue", testGetValue),
        ("testGetValue_default", testGetValue_default),
        ("testGetValue_default_coerce_fail", testGetValue_default_coerce_fail)
    ]
}

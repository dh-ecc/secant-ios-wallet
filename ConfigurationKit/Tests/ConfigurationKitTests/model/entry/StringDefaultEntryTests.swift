import XCTest
@testable import ConfigurationKit

final class StringDefaultEntryTests: XCTestCase {
    func testGetValue() {
        let key = "k"
        let value = "v"
        let defaultValue = "x"

        let entry = StringDefaultEntry(key: key, defaultValue: defaultValue)

        let actual = entry.value(configuration: DictionaryConfiguration(dictionary: [key: value]))

        XCTAssertEqual(actual, value)
    }

    func testGetValue_default() {
        let key = "k"
        let defaultValue = "x"

        let entry = StringDefaultEntry(key: key, defaultValue: defaultValue)

        let actual = entry.value(configuration: DictionaryConfiguration(dictionary: [String: String]()))

        XCTAssertEqual(actual, defaultValue)
    }

    static var allTests = [
        ("testGetValue", testGetValue),
        ("testGetValue_default", testGetValue_default)
    ]
}

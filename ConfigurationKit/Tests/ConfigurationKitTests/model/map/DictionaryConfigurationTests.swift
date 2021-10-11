import XCTest
@testable import ConfigurationKit

final class ConfigurationImplTests: XCTestCase {

    func testMutate() {
        let key = "k"
        let value = "v"

        var dict = [key: value]

        let configuration = DictionaryConfiguration(dictionary: dict)

        dict[key] = "x"

        XCTAssertEqual(configuration.getString(key: key, defaultValue: "y"), value)
    }

    func testGetKey_true() {
        let key = "k"
        let value = "v"

        let configuration = DictionaryConfiguration(dictionary: [key: value])

        XCTAssertTrue(configuration.has(key: key))
    }

    func testGetKey_false() {
        let key = "k"
        let value = "v"

        let configuration = DictionaryConfiguration(dictionary: [key: value])

        XCTAssertFalse(configuration.has(key: key + key))
    }

    func testGetValue_string_exists() {
        let key = "k"
        let value = "v"
        let defaultValue = "x"

        let configuration = DictionaryConfiguration(dictionary: [key: value])

        XCTAssertEqual(configuration.getString(key: key, defaultValue: defaultValue), value)
    }

    func testGetValue_string_default() {
        let key = "k"
        let defaultValue = "x"

        let configuration = DictionaryConfiguration(dictionary: [String: String]())

        XCTAssertEqual(configuration.getString(key: key, defaultValue: defaultValue), defaultValue)
    }

    func testGetValue_bool_exists_true() {
        let key = "k"
        let value = "true"
        let defaultValue = false

        let configuration = DictionaryConfiguration(dictionary: [key: value])

        XCTAssertTrue(configuration.getBool(key: key, defaultValue: defaultValue))
    }

    func testGetValue_bool_exists_false() {
        let key = "k"
        let value = "false"
        let defaultValue = true

        let configuration = DictionaryConfiguration(dictionary: [key: value])

        XCTAssertFalse(configuration.getBool(key: key, defaultValue: defaultValue))
    }

    func testGetValue_bool_default_true() {
        let key = "k"
        let defaultValue = true

        let configuration = DictionaryConfiguration(dictionary: [String: String]())

        XCTAssertTrue(configuration.getBool(key: key, defaultValue: defaultValue))
    }

    func testGetValue_bool_default_false() {
        let key = "k"
        let defaultValue = false

        let configuration = DictionaryConfiguration(dictionary: [String: String]())

        XCTAssertFalse(configuration.getBool(key: key, defaultValue: defaultValue))
    }

    func testGetValue_int() {
        let key = "k"
        let value = 3
        let defaultValue = 5

        let configuration = DictionaryConfiguration(dictionary: [key: "\(value)"])

        XCTAssertEqual(configuration.getInt(key: key, defaultValue: defaultValue), value)
    }

    func testGetValue_int_default() {
        let key = "k"
        let defaultValue = 3

        let configuration = DictionaryConfiguration(dictionary: [String: String]())

        XCTAssertEqual(configuration.getInt(key: key, defaultValue: defaultValue), defaultValue)
    }

    func testGetValue_int_default_coerce_fail() {
        let key = "k"
        let value = "bork"
        let defaultValue = 3

        let configuration = DictionaryConfiguration(dictionary: [key: value])

        XCTAssertEqual(configuration.getInt(key: key, defaultValue: defaultValue), defaultValue)
    }

    static var allTests = [
        ("testMutate", testMutate),

        ("testGetKey_true", testGetKey_true),
        ("testGetKey_false", testGetKey_false),

        ("testGetValue_string_exists", testGetValue_string_exists),
        ("testGetValue_string_default", testGetValue_string_default),

        ("testGetValue_bool_exists_true", testGetValue_bool_exists_true),
        ("testGetValue_bool_exists_false", testGetValue_bool_exists_false),
        ("testGetValue_bool_default_true", testGetValue_bool_default_true),
        ("testGetValue_bool_default_false", testGetValue_bool_default_false),

        ("testGetValue_int", testGetValue_int),
        ("testGetValue_int_default", testGetValue_int_default),
        ("testGetValue_int_default_coerce_fail", testGetValue_int_default_coerce_fail),
    ]
}

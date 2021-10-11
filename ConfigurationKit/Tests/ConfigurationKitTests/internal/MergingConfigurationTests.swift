import XCTest
@testable import ConfigurationKit

final class MultiConfigurationProviderTest: XCTestCase {

    func testUpdatedAt_biggest() {
        let provider = MergingConfiguration(configurations: [Configuration](arrayLiteral: DictionaryConfiguration.empty,
                                                             DictionaryConfiguration(updatedAt: Date(timeIntervalSince1970: 50), dictionary: [String: String]()),
                                                             DictionaryConfiguration(updatedAt: Date(timeIntervalSince1970: 100), dictionary: [String: String]()),
                                                             DictionaryConfiguration(updatedAt: Date(timeIntervalSince1970: 0), dictionary: [String: String]())))

        XCTAssertEqual(provider.updatedAt(), Date(timeIntervalSince1970: 100))
    }

    func testUpdatedAt_empty() {
        let provider = MergingConfiguration(configurations: [Configuration]())

        XCTAssertNil(provider.updatedAt())
    }

    func testUpdatedAt_nil() {
        let provider = MergingConfiguration(configurations: [DictionaryConfiguration.empty])

        XCTAssertNil(provider.updatedAt())
    }

    static var allTests = [
        ("testUpdatedAt_biggest", testUpdatedAt_biggest),
        ("testUpdatedAt_empty", testUpdatedAt_empty),
        ("testUpdatedAt_nil", testUpdatedAt_nil),
    ]
}

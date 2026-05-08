import XCTest
@testable import Foundry

final class FoundryTests: XCTestCase {
    func testVersionIsNonEmpty() {
        XCTAssertFalse(Foundry.version.isEmpty)
    }
}

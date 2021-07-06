import XCTest
@testable import ProductViewer

class RequestCreatorTests: XCTestCase {
    
    func testCreateRequest() {
        let request = RequestCreator.createRequest(with: URLConstants.baseUrl + URLConstants.deals)
        XCTAssertEqual(request?.url?.absoluteString, URLConstants.baseUrl + URLConstants.deals)
    }
    
}

import XCTest
@testable import ProductViewer

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager(session: session)
    }
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testGetRequestWithURL() {
        guard let url = URL(string: "https://mockurl.com") else {
            fatalError("URL can't be empty")
        }
        let urlRequest = URLRequest(url: url)
        networkManager.fetchData(request: urlRequest) { (_) in
            //data and error return here
        }
        XCTAssertEqual(session.lastURL, url)
    }
    func testGetResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        let urlRequest = URLRequest(url: url)
        networkManager.fetchData(request: urlRequest) { (_) in
            //data and error return here
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testGetShouldReturnData() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        var actualData: Data?
        let urlRequest = URLRequest(url: url)
        networkManager.fetchData(request: urlRequest) { (result) in
            //data and error return here
            switch result {
            case .success(let data):
                actualData = data
            case .failure(_):
                break
            }
        }
        XCTAssertNotNil(actualData)
        XCTAssertEqual(actualData, expectedData)
    }
}

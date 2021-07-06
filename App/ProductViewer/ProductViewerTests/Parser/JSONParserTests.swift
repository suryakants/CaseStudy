import XCTest

@testable import ProductViewer

class JSONParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
            
    let emptyJSON = "{ }".data(using: .utf8)
    
    func testJSONParserWithValidJSON() {
        if let jsonData = validJson, let productModelList: ProductList = JSONParser.decodeJson(from: jsonData) {
            XCTAssertEqual(productModelList.products.count, 2)
            XCTAssertEqual(productModelList.products.first?.title, "non mollit veniam ex")
            XCTAssertEqual(productModelList.products.first?.displayString, "$184.06")
            XCTAssertEqual(productModelList.products.first?.id, 0)
            XCTAssertEqual(productModelList.products.first?.imageUrl, "https://picsum.photos/id/0/300/300")
            XCTAssertEqual(productModelList.products.first?.currencySymbol, "$")
            XCTAssertEqual(productModelList.products.first?.amountInCents, 18406)

        }
        else {
            XCTAssertTrue(false)
        }
    }
        
        func testJSONParserWithIEmptyJSON() {
            if let jsonData = emptyJSON {
                if let productModelList: ProductList = JSONParser.decodeJson(from: jsonData){
                    XCTAssert(productModelList.products.count == 0)
                }
            }
        }
        
        func testJSONParserWithInValidJSON() {
            if let jsonData = invalidJson {
                if let _: ProductList = JSONParser.decodeJson(from: jsonData){
                    XCTAssert(false)
                }
                XCTAssert(true)
            }
        }
    }

import XCTest
@testable import Fetch

class ServiceManagerTests: XCTestCase {
    
    var serviceManager: ServiceManager!
    
    override func setUp() {
        super.setUp()
        serviceManager = ServiceManager()
    }
    
    override func tearDown() {
        serviceManager = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertFalse(serviceManager.isOnError)
        XCTAssertTrue(serviceManager.recipes.isEmpty)
    }
    
    func testErrorState() {
        serviceManager.isOnError = true
        XCTAssertTrue(serviceManager.isOnError)
    }
}


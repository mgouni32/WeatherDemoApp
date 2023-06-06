//
//  NetworkManagerTests.swift
//  WeatherAppTests
//
//  Created by Mounika Gouni on 02/06/23.
//

import XCTest
@testable import WeatherApp

class NetworkManagerTests: XCTestCase {

    var mockNetworkManager: MockNetworkManager?
    var viewModel: FeedListViewModel!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        guard let networkManager = self.mockNetworkManager else {
            XCTFail("Network Manager instance is nill")
            return
        }
        viewModel = FeedListViewModel(apiService: networkManager)
        XCTAssertNotNil(networkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func test_fetch_feedList() {
        //Given
        mockNetworkManager?.feedLList =  [FeedList]()
        //When
        viewModel.getWeatherDataBy(name: "Fanci")
        //Assert
        mockNetworkManager?.fetchSuccess()
        XCTAssert(mockNetworkManager?.fetchFeedsListCallCount == 1)
    }
    
    func test_fetch_feedList_failed() {
        //Given
        let error = NSError(domain: "Failed", code: 400, userInfo: ["des": "Failed"])
        //When
        viewModel.getWeatherDataBy(name: "Fanci")
        //Assert
        mockNetworkManager?.fetchFailed(error: error)
        XCTAssertEqual(viewModel.message, error.domain)
    }
        
}

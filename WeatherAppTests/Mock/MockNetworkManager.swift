//
//  MockNetworkManager.swift
//  WeatherAppTests
//
//  Created by Mounika Gouni on 02/06/23.
//

import XCTest
@testable import WeatherApp

class MockNetworkManager: APIServiceProtocol {
    
    var fetchFeedsListCallCount : Int = 0
    var feedLList: [FeedList] = [FeedList]()
    var completeCloser: ((Result<Any, Error>) -> ())?
    
    func fetch(url: URL, requestType: String, parameter: [String : AnyObject]?, completion: @escaping (Result<Any, Error>) -> ()) {
        self.fetchFeedsListCallCount += 1
        completeCloser = completion
    }
    
    func fetchSuccess() {
        completeCloser?(.success([]))
    }
    
    func fetchFailed(error: Error) {
        completeCloser?(.failure(error))
    }
}

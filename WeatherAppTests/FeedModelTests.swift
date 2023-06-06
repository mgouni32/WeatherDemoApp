//
//  FeedModelTests.swift
//  WeatherAppTests
//
//  Created by Mounika Gouni on 02/06/23.
//

import XCTest
@testable import WeatherApp

class FeedModelTests: XCTestCase {

    var feedList: [FeedList] = []
    var mockFeedObject = MockFeedModel()
    override func setUp() {
        feedList = mockFeedObject.getFeedResults()
    }
    
    func test_feedListModel_feed_result() {
        let feedBean = feedList.first
        XCTAssertEqual(feedBean?.name,"Fanci")
        XCTAssertEqual(feedBean?.humidity, "292")
    }
}

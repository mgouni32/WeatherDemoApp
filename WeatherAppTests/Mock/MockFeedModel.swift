//
//  MockFeedModel.swift
//  WeatherAppTests
//
//  Created by Mounika Gouni on 02/06/23.
//

import XCTest
@testable import WeatherApp

class MockFeedModel {
    
    func getFeedResults() -> [FeedList] {
        let feedList = [FeedList(humidity: 90, name: "Fanci", temp: 292)]
        return feedList
    }
}

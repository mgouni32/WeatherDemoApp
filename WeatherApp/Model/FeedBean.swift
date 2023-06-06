//
//  FeedBean.swift
//  WeatherApp
//
//  Created by Mounika Gouni on 02/06/23.
//

import Foundation

struct FeedBean: Codable {
    var results: [FeedList]?
    
    init(data: AnyObject) {
        results = []
        let feedObj = data as? [String: Any]
        guard let feedListObj = feedObj?["main"] as? [String: Any] else  {
            return
        }
        var feed = FeedList()
        feed.humidity = feedListObj["humidity"] as? Int
        feed.temp = feedListObj["temp"] as? Double
        feed.name = feedObj?["name"] as? String
        results?.append(feed)
    }
}

struct FeedList: Codable {
    var humidity: Int?
    var name: String?
    var temp: Double?
}


//
//  FeedListViewModel.swift
//  WeatherApp
//
//  Created by Mounika Gouni on 02/06/23.
//

import UIKit

enum FeedStatus {
    case success
    case failed
}

class FeedListViewModel: NSObject {
    
    let networkManager: APIServiceProtocol

    private(set) var feedList: FeedBean! {
        didSet {
            print(feedList ?? [])
            bindFeedViewModelToController(.success)
        }
    }
    private(set) var message: String!
    
    var bindFeedViewModelToController: ((FeedStatus) -> ()) = {_ in }
    
    init(apiService: APIServiceProtocol = NetworkManager()) {
        self.networkManager = apiService
    }
    
    func getWeatherDataBy(name: String) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=8f536c351f1df74e62f0665d5afc2738")
        networkManager.fetch(url: url!, requestType: "GET", parameter: nil) {[weak self] (result) in
            switch result {
            case .success(let response):
                self?.message = "Success"
                self?.feedList = FeedBean(data: response as AnyObject)
            case .failure(let error):
                self?.message = "Failed"
                print("error \(error)")
                self?.bindFeedViewModelToController(.failed)
            }
        }
    }
}


struct RequestJson: Codable {
    var conversionInformation: String
    var clientContext: String
    var functionRequests: String
        
    enum CodingKeys: String, CodingKey {
        case conversionInformation = "conversionInformation"
        case clientContext = "clientContext"
        case functionRequests = "functionRequests"
    }
}

struct ConversionInformation: Codable {
    var keyCurrency: String?
    var measurementStandard: Int
    var conversionMode: Int
    var magnitudeOverride: String?
    var nullValue: String?
    var dataLanguage: String
    var requestCulture: String
    
    enum CodingKeys: String, CodingKey {
        case keyCurrency = "keyCurrency"
        case measurementStandard = "measurementStandard"
        case conversionMode = "conversionMode"
        case magnitudeOverride = "magnitudeOverride"
        case nullValue = "nullValue"
        case dataLanguage = "dataLanguage"
        case requestCulture = "requestCulture"
    }
}

struct ClientContext: Codable {
    var templatedId: String?
    var clientVersion: String
    var machineId: String
    var disableLogging: Bool
    var is64Bit: Bool
    var keyClientCodes: String?
    var isGrouped: Bool
    var randomClientCodes: String?
    var excelCulture: String
    var requestSource: Int
    var forceLocalQueries: Bool

    enum CodingKeys: String, CodingKey {
        case templatedId = "templatedId"
        case clientVersion = "clientVersion"
        case machineId = "machineId"
        case disableLogging = "disableLogging"
        case is64Bit = "is64Bit"
        case keyClientCodes = "keyClientCodes"
        case isGrouped = "isGrouped"
        case randomClientCodes = "randomClientCodes"
        case excelCulture = "excelCulture"
        case requestSource = "requestSource"
        case forceLocalQueries = "forceLocalQueries"
    }
}

struct FunctionRequest {
    var perspective: String
    var requestedPerspective: String
    var operationType: Int
    var keys: String
    var query: String?
    var functionId: Int
    var fields: [ Any]
    var groomingStrategyApplied: Bool
    var groomedColumnOrdinal: String?
    var groomedRowOrdinal: String?
    var conversionInfo: String?
    var requestedKeys: String?
    var userDefinedFormulas: [Any]
    var groupByField: String?
    
    enum CodingKeys: String, CodingKey {
        case perspective = "perspective"
        case requestedPerspective = "requestedPerspective"
        case operationType = "operationType"
        case keys = "keys"
        case query = "query"
        case functionId = "functionId"
        case fields = "fields"
        case groomingStrategyApplied = "groomingStrategyApplied"
        case groomedColumnOrdinal = "groomedColumnOrdinal"
        case groomedRowOrdinal = "groomedRowOrdinal"
        case conversionInfo = "conversionInfo"
        case requestedKeys = "requestedKeys"
        case userDefinedFormulas = "userDefinedFormulas"
        case groupByField = "groupByField"
    }
}

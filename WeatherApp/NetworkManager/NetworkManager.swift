//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Mounika Gouni on 02/06/23.
//

import Foundation

protocol APIServiceProtocol {
    func fetch(url: URL, requestType: String, parameter: [String: AnyObject]?, completion: @escaping(Result<Any, Error>) -> ())
}

class NetworkManager: APIServiceProtocol {
    
    func fetch(url: URL, requestType: String, parameter: [String: AnyObject]?, completion: @escaping(Result<Any, Error>) -> ()) {
        
        var  urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = requestType
        urlRequest.timeoutInterval = 60
//        urlRequest.cachePolicy = .reloadIgnoringCacheData
//        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        if let params = parameter {
            do {
                let paramsData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                urlRequest.httpBody = paramsData
                
            } catch {
                completion(.failure(error))
            }
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
            }
            if let dataObj = data, let responseObj = response as? HTTPURLResponse {
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: dataObj, options: .mutableContainers)
                    if responseObj.statusCode == 200 {
                        completion(.success(responseJSON))
                    }
                } catch  {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


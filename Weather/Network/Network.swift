//
//  Network.swift
//  Weather
//
//  Created by John Lima on 26/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation
import Alamofire

class Network {
  
  // MARK: - Properties
  static let shared = Network()
  
  // MARK: - Enums
  enum EndPoint: String {
    case location
  }
  
  enum URLAPI: String {
    case weather = "https://www.metaweather.com/api/"
  }
  
  // MARK: - Public Methods
  func fetchWeather(with woeid: Int, completion: @escaping CompletionBlock.FetchLocationWeather) {
    
    let url = URL(string: "\(URLAPI.weather.rawValue)/\(EndPoint.location.rawValue)/\(woeid)")!
    
    Alamofire.request(url).validate().responseJSON { response in
      let result = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? DataType.JSON
      let location = result??.toLocation()
      completion(location, response.error)
    }
  }
  
  func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
}

// MARK: - Extensions
extension Data {
  func toLocation() -> Location? {
    let decoder = JSONDecoder()
    return try? decoder.decode(Location.self, from: self)
  }
}

extension Collection {
  func toLocation() -> Location? {
    guard let location = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted).toLocation() else { return nil }
    return location
  }
}

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
    case location = "location/"
    case search = "search/"
    case lattlong = "?lattlong="
  }
  
  enum URLAPI: String {
    case weather = "https://www.metaweather.com/api/"
    case imageWeatherState = "https://www.metaweather.com/static/img/weather/"
  }
  
  // MARK: - Public Methods
  func fetchWeather(with woeid: Int, completion: @escaping CompletionBlock.FetchLocationWeather) {
    let url = URL(string: URLAPI.weather.rawValue + EndPoint.location.rawValue + String(woeid))!
    Alamofire.request(url).validate().responseJSON { response in
      let result = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? DataType.JSON
      let location = result??.toLocation()
      completion(location, response.error)
    }
  }
  
  func fetchLocationInfo(latitude: Double, longitude: Double, completion: @escaping CompletionBlock.FetchLocationInfo) {
    let url = URL(string: URLAPI.weather.rawValue + EndPoint.location.rawValue + EndPoint.search.rawValue + EndPoint.lattlong.rawValue + "\(latitude),\(longitude)")!
    Alamofire.request(url).validate().responseJSON { response in
      let items = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? [DataType.JSON]
      let result = items??.first?.toLocationInfo()
      completion(result, response.error)
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
  
  func toLocationInfo() -> LocationInfo? {
    let decoder = JSONDecoder()
    return try? decoder.decode(LocationInfo.self, from: self)
  }
}

extension Collection {
  
  func toLocation() -> Location? {
    guard let location = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted).toLocation() else { return nil }
    return location
  }
  
  func toLocationInfo() -> LocationInfo? {
    guard let info = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted).toLocationInfo() else { return nil }
    return info
  }
}

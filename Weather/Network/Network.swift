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
  func fetchWeather(with woeid: Int, completion: @escaping CompletionBlock.FetchWeather) {
    
    let url = URL(string: "\(URLAPI.weather.rawValue)/\(EndPoint.location.rawValue)/\(woeid)")!
    
    Alamofire.request(url).validate().responseJSON { response in
      let result = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? [DataType.JSON]
      let weather = result ?? nil
      completion(weather, response.error)
    }
  }
  
  func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
}

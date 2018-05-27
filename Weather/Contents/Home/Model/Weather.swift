//
//  Weather.swift
//  Weather
//
//  Created by John Lima on 26/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

struct Weather: Codable {
  
  let id: String
  let stateAbbreviation: String
  let date: String
  let minTemp: Double
  let maxTemp: Double
  let currentTemp: Double
  
  private enum CodingKeys: String, CodingKey {
    case id
    case stateAbbreviation = "weather_state_abbr"
    case date = "applicable_date"
    case minTemp = "min_temp"
    case maxTemp = "max_temp"
    case currentTemp = "the_temp"
  }
}

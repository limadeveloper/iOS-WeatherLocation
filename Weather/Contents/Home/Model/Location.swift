//
//  Location.swift
//  Weather
//
//  Created by John Lima on 26/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

struct Location: Codable {
  
  let sunrise: String
  let sunset: String
  let title: String
  let locationType: String
  let woeid: Int
  let coordinates: String
  let timezone: String
  let weather: [Weather]
  
  private enum CodingKeys: String, CodingKey {
    case title, woeid, timezone
    case sunrise = "sun_rise"
    case sunset = "sun_set"
    case locationType = "location_type"
    case coordinates = "latt_long"
    case weather = "consolidated_weather"
  }
}

//
//  LocationManager.swift
//  Weather
//
//  Created by John Lima on 28/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

class LocationManager {
  
  // MARK: - Properties
  static let shared = LocationManager()
  
  // MARK: - Public Methods
  func getCoordinates() -> Coordinate? {
    let result = Coordinate(title: "San Francisco", woeid: 2487956, latitude: "37.777119", longitude: "-122.41964")
    return result
  }
}

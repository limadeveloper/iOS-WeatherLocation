//
//  LocationInfo.swift
//  Weather
//
//  Created by John Lima on 28/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

struct LocationInfo: Codable {
  let title: String
  let woeid: Int
  var latitude: String?
  var longitude: String?
}

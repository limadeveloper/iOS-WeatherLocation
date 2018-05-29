//
//  TypeAlias.swift
//  Weather
//
//  Created by John Lima on 26/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

struct CompletionBlock {
  typealias FetchLocationWeather = (Location?, Error?) -> Void
  typealias FetchLocationInfo = (LocationInfo?, Error?) -> Void
  typealias Empty = () -> Void
}

struct DataType {
  typealias JSON = [AnyHashable: Any?]
}

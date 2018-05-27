//
//  DateUtil.swift
//  Weather
//
//  Created by John Lima on 27/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

class DateUtil {
  
  // MARK: - Enums
  enum DateFormat: String {
    case usaByDash = "yyyy-MM-dd"
    case brShortDate = "dd/MM"
  }
}

// MARK: - Extensions
extension String {
  
  var toDateFromUSAFormat: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = DateUtil.DateFormat.usaByDash.rawValue
    let result = formatter.date(from: self)
    return result
  }
  
  var isToday: Bool {
    let formatter = DateFormatter()
    formatter.dateFormat = DateUtil.DateFormat.usaByDash.rawValue
    let now = formatter.string(from: Date())
    let result = now == self
    return result
  }
  
  var shortDate: String? {
    guard let date = self.toDateFromUSAFormat else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = DateUtil.DateFormat.brShortDate.rawValue
    let result = formatter.string(from: date)
    return result
  }
}

extension Sequence where Iterator.Element == Weather {
  var todayMaxTemperature: Double? {
    let weather = self.filter { $0.date.isToday }.first
    return weather?.currentTemp
  }
}

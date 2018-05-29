//
//  SessionManager.swift
//  Weather
//
//  Created by John Lima on 28/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

class SessionManager {
  
  // MARK: - Properties
  static let shared = SessionManager()
  
  var degreeScale: DegreeScale = .celsius
  
  // MARK: - Enums
  enum DegreeScale: String {
    case celsius = "Cº"
    case fahrenheit = "Fº"
  }
}

extension Double {
  var toDegreeScale: Double {
    switch SessionManager.shared.degreeScale {
    case .fahrenheit:
      return self * 9 / 5 + 32
    default:
      return self
    }
  }
}

//
//  ErrorHandler.swift
//  Weather
//
//  Created by John Lima on 27/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

class ErrorHandler {
  
  // MARK: - Properties
  static let shared = ErrorHandler()
  
  // MARK: - Public Methods
  func showToastAlert(_ error: Error, target: AnyObject) {
    print(" error: \(error)")
  }
}

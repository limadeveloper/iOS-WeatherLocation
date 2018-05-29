//
//  ErrorHandler.swift
//  Weather
//
//  Created by John Lima on 27/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit

class ErrorHandler {
  
  // MARK: - Constants
  private let kTimeIntervalDismissAlert: TimeInterval = 5
  
  // MARK: - Properties
  static let shared = ErrorHandler()
  
  private var alert: UIAlertController?
  private var timer = Timer()
  
  // MARK: - Enums
  enum ErrorMessage: String {
    case error = "Error"
    case noConnection = "No connection"
    case checkConnection = "Check your internet connection and try again"
  }
  
  // MARK: - Public Methods
  func showToastAlert(_ error: Error, target: UIViewController?) {
    alert = AlertManager.shared.getToastAlert(in: target, title: "☹︎ \(ErrorMessage.error.rawValue)", message: error.localizedDescription)
    timer = Timer.scheduledTimer(timeInterval: kTimeIntervalDismissAlert, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
  }
  
  func allowAccessLocation(in target: UIViewController?) {
    let allowAction = UIAlertAction(title: "Allow", style: .default) { _ in
      guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    AlertManager.shared.createAlert(
      title: "Allow Location",
      message: "I need know where're you to show the weather for your location",
      actions: [cancelAction, allowAction],
      target: target
    )
  }
  
  // MARK: - Private Methods
  @objc private func dismissAlert() {
    alert?.dismiss(animated: true) {
      self.timer.invalidate()
    }
  }
}

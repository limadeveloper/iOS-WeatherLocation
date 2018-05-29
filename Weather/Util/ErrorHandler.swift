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
  
  // MARK: - Public Methods
  func showToastAlert(_ error: Error, target: UIViewController?) {
    alert = AlertManager.shared.getToastAlert(in: target, title: "☹︎ \(LocalizedUtil.Text.error)", message: error.localizedDescription)
    timer = Timer.scheduledTimer(timeInterval: kTimeIntervalDismissAlert, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
  }
  
  func allowAccessLocation(in target: UIViewController?) {
    let allowAction = UIAlertAction(title: LocalizedUtil.Text.alertButtonAllow, style: .default) { _ in
      guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    let cancelAction = UIAlertAction(title: LocalizedUtil.Text.alertButtonCancel, style: .destructive, handler: nil)
    AlertManager.shared.createAlert(
      title: LocalizedUtil.Text.alertTitleAllowLocation,
      message: LocalizedUtil.Text.alertMessageAllowLocation,
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

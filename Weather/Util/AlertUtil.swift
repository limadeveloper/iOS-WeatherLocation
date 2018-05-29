//
//  AlertUtil.swift
//  Weather
//
//  Created by John Lima on 28/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit

class AlertManager {
  
  // MARK: - Properties
  static let shared = AlertManager()
  
  // MARK: - Public Methods
  func getToastAlert(in target: AnyObject?, title: String? = nil, message: String? = nil) -> UIAlertController {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet
    )
    DispatchQueue.main.async {
      target?.present(alert, animated: true, completion: nil)
    }
    return alert
  }
  
  func createAlert(title: String? = nil, message: String? = nil, style: UIAlertControllerStyle = .alert, actions: [UIAlertAction]? = [UIAlertAction(title: LocalizedUtil.Text.alertButtonDone, style: .cancel, handler: nil)], target: AnyObject?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    if let actions = actions {
      for action in actions {
        alert.addAction(action)
      }
    }
    DispatchQueue.main.async {
      target?.present(alert, animated: true, completion: nil)
    }
  }
}

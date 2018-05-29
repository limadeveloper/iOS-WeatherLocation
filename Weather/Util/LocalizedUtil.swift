//
//  LocalizedUtil.swift
//  Weather
//
//  Created by John Lima on 28/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation

struct LocalizedUtil {
  struct Text {
    static let alertButtonDone = "alert.button.done".localized()
    static let alertButtonAllow = "alert.button.allow".localized()
    static let alertButtonCancel = "alert.button.cancel".localized()
    static let alertTitleAllowLocation = "alert.title.allowLocation".localized()
    static let alertMessageAllowLocation = "alert.message.allowLocation".localized()
    static let error = "error.error".localized()
    static let errorCellIdentifier = "error.cellIdentifier".localized()
    static let homeDegreeScaleFahrenheit = "home.degreeScaleLabel.fahrenheit".localized()
    static let homeDegreeScaleCelsius = "home.degreeScaleLabel.celsius".localized()
  }
}

extension String {
  func localized(withComment comment: String? = nil) -> String {
    return NSLocalizedString(self, comment: comment ?? String())
  }
}

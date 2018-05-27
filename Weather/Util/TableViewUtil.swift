//
//  TableViewUtil.swift
//  Weather
//
//  Created by John Lima on 27/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit

private let kErrorDequeueCellIdenfier = "Could not dequeue cell with identifier"

extension UITableView {
  
  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
    register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }
  
  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NIBLoadableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
      fatalError("\(kErrorDequeueCellIdenfier): \(T.defaultReuseIdentifier)")
    }
    return cell
  }
}

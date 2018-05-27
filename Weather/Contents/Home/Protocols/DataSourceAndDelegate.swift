//
//  DataSourceAndDelegate.swift
//  Weather
//
//  Created by John Lima on 27/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit

class DataSourceAndDelegate: NSObject {
  
  // MARK: - Properties
  private var controller: HomeViewController?
  
  // MARK: - Initializers
  init(with controller: HomeViewController?) {
    super.init()
    self.controller = controller
  }
}

// MARK: - Extensions
extension DataSourceAndDelegate: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return controller?.locationWeather?.weather.count ?? Int()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: HomeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.weather = controller?.locationWeather?.weather[indexPath.row]
    return cell
  }
}

//
//  HomeViewController.swift
//  Weather
//
//  Created by John Lima on 26/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
  
  // MARK: - Constants
  private let degreeSymbol = "º"
  private let tempEmpty = "--"
  private let breaklineSymbol = "\n"
  private let tableBorderWidth: CGFloat = 2
  private let tableBorderColor: UIColor = .groupTableViewBackground
  
  // MARK: - Properties
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var temperatureScaleSwitch: UISwitch!
  
  let locationManager = LocationManager.shared
  var locationWeather: Location?
  var locationInfo: LocationInfo?
  
  // swiftlint:disable weak_delegate
  var dataSourceAndDelegate: DataSourceAndDelegate?
  
  // MARK: - Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
    loadData()
  }
  
  // MARK: - Public Methods
  func loadDeviceLocation() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    locationManager.fetchLocationInfo { [weak self] result, _ in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      guard let strongSelf = self else { return }
      strongSelf.locationInfo = result
      strongSelf.loadData()
      strongSelf.locationManager.count = Int()
    }
  }
  
  // MARK: - Private Methods
  private func updateUI() {
    
    dataSourceAndDelegate = DataSourceAndDelegate(with: self)
    
    let footer = UIView(frame: .zero)
    tableView.tableFooterView = footer
    tableView.dataSource = dataSourceAndDelegate
    
    let objects: [UIView] = [tableView, mapView]
    
    for object in objects {
      object.layer.borderWidth = tableBorderWidth
      object.layer.borderColor = tableBorderColor.cgColor
    }
    
    locationManager.delegate = dataSourceAndDelegate
  }
  
  private func updateMapLocationPoint() {
    let latitude = Double(locationInfo?.latitude ?? String()) ?? locationManager.kDefaultLatitude
    let longitude = Double(locationInfo?.longitude ?? String()) ?? locationManager.kDefaultLongitude
    let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let region = MKCoordinateRegion(center: center, span: locationManager.coordinateSpan)
    mapView.setRegion(region, animated: true)
  }
  
  private func loadData() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    Network.shared.fetchWeather(with: locationInfo?.woeid ?? locationManager.kDefaultWOEID) { [weak self] (location, error) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      guard let strongSelf = self else { return }
      if let error = error {
        ErrorHandler.shared.showToastAlert(error, target: strongSelf)
        return
      }
      strongSelf.locationWeather = location
      strongSelf.showData()
    }
  }
  
  private func showData() {
    guard let location = locationWeather else { return }
    titleLabel.text = location.title + breaklineSymbol + getTodayTemp(by: location)
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.tableView.reloadData()
      strongSelf.updateMapLocationPoint()
    }
  }
  
  private func getTodayTemp(by location: Location) -> String {
    var result = tempEmpty
    if let temp = location.weather.todayMaxTemperature {
      result = String(Int(temp)) + degreeSymbol
    }
    return result
  }
}

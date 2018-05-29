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
  private let kDegreeSymbol = "º"
  private let kTempEmpty = "--"
  private let kBreaklineSymbol = "\n"
  private let kTableBorderWidth: CGFloat = 2
  private let kTableBorderColor: UIColor = .groupTableViewBackground
  private let kDegreeLabelFontSize: CGFloat = 17
  
  // MARK: - Properties
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var degreeScaleLabel: UILabel!
  
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
  
  // MARK: - Actions
  @IBAction private func changeValue(sender: UISwitch) {
    SessionManager.shared.degreeScale = .celsius
    if sender.isOn {
      SessionManager.shared.degreeScale = .fahrenheit
    }
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
      object.layer.borderWidth = kTableBorderWidth
      object.layer.borderColor = kTableBorderColor.cgColor
    }
    
    LocationManager.shared.requestAuthorization(in: self)
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
    titleLabel.text = location.title + kBreaklineSymbol + getTodayTemp(by: location)
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.tableView.reloadData()
      strongSelf.updateMapLocationPoint()
      strongSelf.setDegreeScaleLabel()
    }
  }
  
  private func getTodayTemp(by location: Location) -> String {
    var result = kTempEmpty
    if let temp = location.weather.todayMaxTemperature {
      result = String(Int(temp.toDegreeScale)) + kDegreeSymbol
    }
    return result
  }
  
  private func setDegreeScaleLabel() {
    let boldFontAttributed: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: kDegreeLabelFontSize, weight: .bold)]
    let lightFontAttributed: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: kDegreeLabelFontSize, weight: .light)]
    switch SessionManager.shared.degreeScale {
    case .fahrenheit:
      let attributedText = NSMutableAttributedString(string: LocalizedUtil.Text.homeDegreeScaleCelsius, attributes: lightFontAttributed)
      let fahrenheitAttributedText = NSAttributedString(string: " / \(LocalizedUtil.Text.homeDegreeScaleFahrenheit)", attributes: boldFontAttributed)
      attributedText.append(fahrenheitAttributedText)
      degreeScaleLabel.attributedText = attributedText
    default:
      let attributedText = NSMutableAttributedString(string: "\(LocalizedUtil.Text.homeDegreeScaleCelsius) / ", attributes: boldFontAttributed)
      let fahrenheitAttributedText = NSAttributedString(string: LocalizedUtil.Text.homeDegreeScaleFahrenheit, attributes: lightFontAttributed)
      attributedText.append(fahrenheitAttributedText)
      degreeScaleLabel.attributedText = attributedText
    }
  }
}

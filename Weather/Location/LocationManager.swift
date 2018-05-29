//
//  LocationManager.swift
//  Weather
//
//  Created by John Lima on 28/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationManagerDelegate: class {
  func locationManagerdidUpdateLocations()
}

class LocationManager: NSObject {
  
  // MARK: - Constants
  let kIncrement = 1
  let kRequestInterval = 7
  let kDefaultWOEID = 2487956
  let kDefaultLatitude = 37.777119
  let kDefaultLongitude = -122.41964
  let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
  
  // MARK: - Properties
  static let shared = LocationManager()
  
  private var manager = CLLocationManager()
  private var currentCoordinate: CLLocationCoordinate2D?
  
  var count = Int()
  weak var controller: UIViewController?
  weak var delegate: LocationManagerDelegate?
  
  // MARK: - Public Methods
  func requestAuthorization(in target: UIViewController?) {
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    controller = target
  }
    
  func fetchLocationInfo(completion: CompletionBlock.FetchLocationInfo?) {
    guard let coordinate = currentCoordinate else { completion?(nil, nil); return }
    Network.shared.fetchLocationInfo(latitude: coordinate.latitude, longitude: coordinate.longitude) { (locationInfo, error) in
      var result = locationInfo
      result?.latitude = String(coordinate.latitude)
      result?.longitude = String(coordinate.longitude)
      completion?(result, error)
    }
  }
}

// MARK: - Extensions
extension LocationManager: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      manager.startUpdatingLocation()
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .denied:
      ErrorHandler.shared.allowAccessLocation(in: controller)
    default:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let coordinate = manager.location?.coordinate else { return }
    currentCoordinate = coordinate
    count += kIncrement
    delegate?.locationManagerdidUpdateLocations()
  }
}

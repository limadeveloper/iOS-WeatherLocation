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
  let kDefaultLatitude = 50.068
  let kDefaultLongitude = -5.316
  let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
  
  // MARK: - Properties
  static let shared = LocationManager()
  
  private var manager = CLLocationManager()
  private var currentCoordinate: CLLocationCoordinate2D?
  
  var count = Int()
  weak var delegate: LocationManagerDelegate?
  
  // MARK: - Public Methods
  func requestAuthorization() {
    manager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      manager.delegate = self
      manager.desiredAccuracy = kCLLocationAccuracyBest
      manager.startUpdatingLocation()
    } else {
      // TODO: Show alert to permit access location
    }
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
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let coordinate = manager.location?.coordinate else { return }
    currentCoordinate = coordinate
    count += kIncrement
    delegate?.locationManagerdidUpdateLocations()
  }
}

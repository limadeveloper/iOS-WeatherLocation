//
//  HomeTableViewCell.swift
//  Weather
//
//  Created by John Lima on 27/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell, ReusableView {
  
  // MARK: - Constants
  private let emptyDate = "📅"
  private let degreeSymbol = "º"
  private let weatherTypeImage = "png"
  private let weatherSizeImage = "120"
  private let weatherStateImageFrame = CGRect(x: CGFloat(), y: CGFloat(), width: 44, height: 44)
  
  // MARK: - Properties
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var maxTemperatureLabel: UILabel!
  
  var weather: Weather? {
    didSet {
      guard let weather = weather else { return }
      dateLabel.text = weather.date.shortDate ?? emptyDate
      maxTemperatureLabel.text = String(Int(weather.maxTemp)) + degreeSymbol
      addAccessoryView(with: weather)
    }
  }
  
  // MARK: - Overrides
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  // MARK: - Private Methods
  private func addAccessoryView(with weather: Weather) {
    let imageView = UIImageView(frame: weatherStateImageFrame)
    let imageURL = URL(string: Network.URLAPI.weather.rawValue + Network.EndPoint.imageWeatherState.rawValue + "\(weatherTypeImage)/\(weatherSizeImage)/\(weather.stateAbbreviation).\(weatherTypeImage)")!
    print(" URL image: \(imageURL)")
    accessoryView = imageView
  }
}

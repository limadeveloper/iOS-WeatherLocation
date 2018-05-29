//
//  HomeTableViewCell.swift
//  Weather
//
//  Created by John Lima on 27/05/18.
//  Copyright © 2018 limadeveloper. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeTableViewCell: UITableViewCell, ReusableView {
  
  // MARK: - Constants
  private let emptyDate = "📅"
  private let degreeSymbol = "º"
  private let weatherTypeImage = "png"
  private let stringEndpointAPI = "api/"
  private let weatherStateImageFrame = CGRect(x: CGFloat(), y: CGFloat(), width: 30, height: 30)
  
  // MARK: - Properties
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var maxTemperatureLabel: UILabel!
  
  var weather: Weather? {
    didSet {
      guard let weather = weather else { return }
      dateLabel.text = weather.date.shortDate ?? emptyDate
      maxTemperatureLabel.text = String(Int(weather.maxTemp.toDegreeScale)) + degreeSymbol
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
    imageView.contentMode = .scaleAspectFit
    let stringImage = Network.URLAPI.imageWeatherState.rawValue + weatherTypeImage + "/\(weather.stateAbbreviation).\(weatherTypeImage)"
    let imageURL = URL(string: stringImage.replacingOccurrences(of: stringEndpointAPI, with: String()))!
    imageView.af_setImage(withURL: imageURL, placeholderImage: #imageLiteral(resourceName: "weather"))
    accessoryView = imageView
  }
}

//
//  WeatherViewState.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/14.
//
import UIKit

struct WeatherViewState {
    let weather: UIImage
    let color: UIColor
    let lowestTemperature: String
    let highestTemperature: String
    
    init(_ weather: WeatherInformation.Weather, _ lowestTemperature: String, _ highestTemperature: String) {
        self.weather = UIImage(named: weather.rawValue)!
        self.lowestTemperature = lowestTemperature
        self.highestTemperature = highestTemperature
        switch weather {
        case .sunny:
            self.color = .red
        case .cloudy:
            self.color = .gray
        case .rainy:
            self.color = .blue
        }
    }
}


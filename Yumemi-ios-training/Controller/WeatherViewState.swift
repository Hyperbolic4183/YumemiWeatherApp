//
//  WeatherViewState.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/14.
//
import UIKit

struct WeatherViewState: Equatable {
    let weather: UIImage
    let color: UIColor
    let minTemperature: String
    let maxTemperature: String
    
    init(weather: WeatherInformation.Weather, minTemperature: String, maxTemperature: String) {
        self.weather = UIImage(named: weather.rawValue)!
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
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


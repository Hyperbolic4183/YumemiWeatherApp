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
    let minTemperature: String
    let maxTemperature: String
    
    init(information: WeatherInformation) {
        self.weather = UIImage(named: information.weather.rawValue)!
        self.minTemperature = information.minTemperature
        self.maxTemperature = information.maxTemperature
        switch information.weather {
        case .sunny:
            self.color = .red
        case .cloudy:
            self.color = .gray
        case .rainy:
            self.color = .blue
        }
    }
}


//
//  WeatherInformation.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/20.
//

struct WeatherInformation {
    init(_ weather: Weather, _ minTemperature: String, _ maxTemperature: String) {
        self.weather = weather
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
    }
    enum Weather: String {
        case sunny
        case cloudy
        case rainy
    }
    var weather: Weather
    var minTemperature: String
    var maxTemperature: String
}

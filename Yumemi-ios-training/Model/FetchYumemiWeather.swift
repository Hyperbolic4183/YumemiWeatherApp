//
//  FetchYumemiWeather.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/07/07.
//

import YumemiWeather
import Foundation

class FetchYumemiWeather: WeatherAppManagerDelegate {

    static let shared = FetchYumemiWeather()
    var manager = WeatherAppManager()
    
    init() {
        manager.delegate = self
    }
    
    func weatherAppManager(_ manager: WeatherAppManager, didFailWithError error: Error) -> YumemiWeatherError? {
        error as? YumemiWeatherError
    }
    
    func weatherAppManager(_ manager: WeatherAppManager, didReload jsonString: String) throws -> String {
        try YumemiWeather.syncFetchWeather(jsonString)
    }
}

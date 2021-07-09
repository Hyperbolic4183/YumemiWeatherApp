//
//  FetchYumemiWeather.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/07/07.
//

import YumemiWeather

class FetchYumemiWeather: WeatherAppManagerDelegate {

    static let shared = FetchYumemiWeather()
    var fetcher = WeatherAppManager()
    
    init() {
        fetcher.delegate = self
    }
    
    func weatherAppManager(_ manager: WeatherAppManager, didFailWithError error: Error) -> YumemiWeatherError? {
        error as? YumemiWeatherError
    }
    
    func weatherAppManager(_ manager: WeatherAppManager, didUpdate jsonString: String) throws -> String {
        try YumemiWeather.syncFetchWeather(jsonString)
    }
}

//
//  WeatherModel.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/12.
//

import YumemiWeather
import Foundation



struct WeatherModel {
    
    func reloading() -> Result<WeatherViewState, WeatherAppError> {
        do {
            let weatherDataString = try YumemiWeather.fetchWeather("{\"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }")
            let weatherData = weatherDataString.data(using: String.Encoding.utf8)!
            let weatherDictionary = jsonMappedDictionary(weatherData: weatherData)
            let weather = Weather(rawValue: weatherDictionary!["weather"] as! String)!
            let lowestTemperature = weatherDictionary!["min_temp"] as! Int
            let highestTemperature = weatherDictionary!["max_temp"] as! Int
            return .success(WeatherViewState(weather: weather, lowestTemperature: lowestTemperature, highestTemperature: highestTemperature))
        } catch let error as YumemiWeatherError {
            switch error {
            case .invalidParameterError:
                return .failure(.invalidParameterError)
            case .unknownError:
                return .failure(.unknownError)
            }
        } catch {
            fatalError("想定外のエラーが発生しました")
        }
    }
    
    func jsonMappedDictionary(weatherData: Data) -> [String: Any]? {
        do {
            let weatherDictionary = try JSONSerialization.jsonObject(with: weatherData) as? Dictionary<String, Any>
            return weatherDictionary
        } catch {
            return nil
        }
    }
}

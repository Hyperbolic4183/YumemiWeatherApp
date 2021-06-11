//
//  Fetcher.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/12.
//

import YumemiWeather
import Foundation

struct Fetcher {
    
    func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
        do {
            let weatherDataString = try YumemiWeather.fetchWeather("{\"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }")
            let weatherData = Data(weatherDataString.utf8)
            guard let weatherResponse = convert(from: weatherData),
                  let weather = WeatherInformation.Weather(rawValue: weatherResponse.weather) else { return .failure(.unknownError) }
            let minTemperature = String(weatherResponse.minTemp)
            let maxTemperature = String(weatherResponse.maxTemp)
            let weatherInformation = WeatherInformation(weather: weather, minTemperature: minTemperature, maxTemperature: maxTemperature)
            return .success(weatherInformation)
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
    
    func convert(from weatherData: Data) -> WeatherResponse? {
        do {
            let weatherDictionary = try JSONSerialization.jsonObject(with: weatherData) as? [String: Any]
            guard let weather = weatherDictionary?["weather"] as? String,
                  let minTemp = weatherDictionary?["min_temp"] as? Int,
                  let maxTemp = weatherDictionary?["max_temp"] as? Int,
                  let dateString = weatherDictionary?["date"] as? String else {
                assertionFailure("JSONから辞書型への変換に失敗した")
                return nil
            }
            guard let date = dateFormat(from: dateString) else {
                assertionFailure("String->Dateの変換に失敗した")
                return nil
            }
            let weatherResponse = WeatherResponse(weather: weather, minTemp: minTemp, maxTemp: maxTemp, date: date)
            return weatherResponse
        } catch {
            return nil
        }
    }
    func dateFormat(from date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        return dateFormatter.date(from: date)
    }
}

//
//  WeatherAppManager.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/12.
//

import YumemiWeather
import Foundation

protocol FetcherDelegate: AnyObject {
    func fetchManager(_ manager: Fetcher, didReload information: WeatherInformation)
    func fetchManager(_ manager: Fetcher, didFailWithError error: WeatherAppError)
}

class Fetcher {
    
    weak var delegate: FetcherDelegate?
    
    func fetch() {
        do {
            let weatherDataString = try YumemiWeather.syncFetchWeather("{\"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }")
            let weatherData = Data(weatherDataString.utf8)
            guard let weatherResponse = convert(from: weatherData) else {
                assertionFailure("convertに失敗")
                return
            }
            guard let weather = WeatherInformation.Weather(rawValue: weatherResponse.weather) else {
                assertionFailure("Weatherのイニシャライザに失敗")
                return
            }
            let minTemperature = String(weatherResponse.minTemp)
            let maxTemperature = String(weatherResponse.maxTemp)
            let weatherInformation = WeatherInformation(weather: weather, minTemperature: minTemperature, maxTemperature: maxTemperature)
            delegate?.fetchManager(self, didReload: weatherInformation)
        } catch let error as YumemiWeatherError {
            switch error {
            case .invalidParameterError:
                delegate?.fetchManager(self, didFailWithError: .invalidParameterError)
            case .unknownError:
                delegate?.fetchManager(self, didFailWithError: .unknownError)
            }
        } catch {
            assertionFailure("予期せぬエラーが発生しました")
            delegate?.fetchManager(self, didFailWithError: .unknownError)
        }
    }
    
    func convert(from weatherData: Data) -> WeatherResponse? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: weatherData)
            return weatherResponse
        } catch {
            assertionFailure("decodeに失敗した")
            return nil
        }
    }
}

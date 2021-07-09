//
//  WeatherAppManager.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/12.
//

import YumemiWeather
import Foundation

protocol WeatherAppManagerDelegate: AnyObject {
    func weatherAppManager(_ manager: WeatherAppManager, didUpdate jsonString: String) throws -> String
    func weatherAppManager(_ manager: WeatherAppManager, didFailWithError error: Error) -> YumemiWeatherError?
}

class WeatherAppManager: Fetchable {
    
    var delegate: WeatherAppManagerDelegate?
    deinit {
        print("Fetcher released")
    }
    
    func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
        do {
            guard  let weatherDataString = try delegate?.weatherAppManager(self, didUpdate: "{\"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }") else {
                assertionFailure("weatherDataStringの変換に失敗しました")
                return .failure(.unknownError)
            }
            let weatherData = Data(weatherDataString.utf8)
            guard let weatherResponse = convert(from: weatherData),
                  let weather = WeatherInformation.Weather(rawValue: weatherResponse.weather) else { return .failure(.unknownError) }
            let minTemperature = String(weatherResponse.minTemp)
            let maxTemperature = String(weatherResponse.maxTemp)
            let weatherInformation = WeatherInformation(weather: weather, minTemperature: minTemperature, maxTemperature: maxTemperature)
            return .success(weatherInformation)
            
        } catch let error {
            guard let _error = delegate?.weatherAppManager(self, didFailWithError: error) else {
                assertionFailure("エラーの変換に失敗しました")
                return .failure(.unknownError)
            }
            switch _error {
            case .invalidParameterError:
                return .failure(.invalidParameterError)
            case .unknownError:
                return .failure(.unknownError)
            }
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

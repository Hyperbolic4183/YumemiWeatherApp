//
//  Fetcher.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/12.
//

import YumemiWeather
import Foundation

struct Fetcher: Fetchable {
    
    func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
        do {
            let weatherDataString = try YumemiWeather.syncFetchWeather("{\"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }")
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
            assertionFailure("想定外のエラーが発生しました")
            return .failure(.unknownError)
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

//
//  Fetcher.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/12.
//

import YumemiWeather
import Foundation

protocol Fetchable {
    func fetch(completion: @escaping (_ result: Result<WeatherInformation, WeatherAppError>) -> Void)
}

final class Fetcher: Fetchable {
    
    func fetch(completion: @escaping (_ result: Result<WeatherInformation, WeatherAppError>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            let result: Result<WeatherInformation, WeatherAppError>
            do {
                let weatherDataString = try YumemiWeather.syncFetchWeather("{\"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }")
                let weatherData = Data(weatherDataString.utf8)
                guard let weatherResponse = self?.convert(from: weatherData) else {
                    assertionFailure("convertに失敗")
                    result = .failure(.unknownError)
                    return
                }
                guard let weather = WeatherInformation.Weather(rawValue: weatherResponse.weather) else {
                    assertionFailure("Weatherのイニシャライザに失敗")
                    result = .failure(.unknownError)
                    return
                }
                let minTemperature = String(weatherResponse.minTemp)
                let maxTemperature = String(weatherResponse.maxTemp)
                let weatherInformation = WeatherInformation(weather: weather, minTemperature: minTemperature, maxTemperature: maxTemperature)
                result = .success(weatherInformation)
            } catch let error as YumemiWeatherError {
                switch error {
                case .invalidParameterError:
                    result = .failure(.invalidParameterError)
                case .unknownError:
                    result = .failure(.unknownError)
                }
            } catch {
                assertionFailure("想定外のエラーが発生しました")
                result = .failure(.unknownError)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    private func convert(from weatherData: Data) -> WeatherResponse? {
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

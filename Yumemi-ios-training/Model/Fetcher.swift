//
//  Fetcher.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/12.
//

import YumemiWeather
import Foundation

final class Fetcher: Fetchable {
    
    weak var delegate: FetchableDelegate?
    
    func fetch() {
        DispatchQueue.global().async { [weak self] in
            do {
                let weatherDataString = try YumemiWeather.syncFetchWeather("{\"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }")
                let weatherData = Data(weatherDataString.utf8)
                guard let weatherResponse = self?.convert(from: weatherData) else {
                    assertionFailure("convertに失敗")
                    self?.delegate?.fetch(self, didFailWithError: .unknownError)
                    return
                }
                guard let weather = WeatherInformation.Weather(rawValue: weatherResponse.weather) else {
                    assertionFailure("Weatherのイニシャライザに失敗")
                    self?.delegate?.fetch(self, didFailWithError: .unknownError)
                    return
                }
                let minTemperature = String(weatherResponse.minTemp)
                let maxTemperature = String(weatherResponse.maxTemp)
                let weatherInformation = WeatherInformation(weather: weather, minTemperature: minTemperature, maxTemperature: maxTemperature)
                self?.delegate?.fetch(self, didFetch: weatherInformation)
            } catch let error as YumemiWeatherError {
                switch error {
                case .invalidParameterError:
                    self?.delegate?.fetch(self, didFailWithError: .invalidParameterError)
                case .unknownError:
                    self?.delegate?.fetch(self, didFailWithError: .unknownError)
                }
            } catch {
                assertionFailure("予期せぬエラーが発生しました")
                self?.delegate?.fetch(self, didFailWithError: .unknownError)
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

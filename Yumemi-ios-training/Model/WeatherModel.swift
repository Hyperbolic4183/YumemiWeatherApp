//
//  WeatherModel.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/05/12.
//

import YumemiWeather
import Foundation

struct WeatherModel {
    
    func reloading() -> Result<[String: Any], WeatherAppError> {
        do {
            let weatherDataString = try YumemiWeather.fetchWeather("{\"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }")
            let weatherData = Data(weatherDataString.utf8)
            let weatherDictionary = convert(from: weatherData)
            return .success(weatherDictionary!)
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
    
    func convert(from weatherData: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: weatherData) as? [String: Any]
        } catch {
            assertionFailure("JSONSerializationには失敗しないはず")
            return nil
        }
    }
}

//
//  Yumemi_ios_trainingTests.swift
//  Yumemi-ios-trainingTests
//
//  Created by 大塚 周 on 2021/06/18.
//

import XCTest
@testable import Yumemi_ios_training

class Yumemi_ios_trainingTests: XCTestCase {
    
    func test_天気予報がsunnyだったときに画面に晴れ画像が表示される() {
        
        struct Sunny: Testable {
            func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
                .success(WeatherInformation(weather: .sunny, minTemperature: "0", maxTemperature: "0"))
            }
        }
        let viewController = WeatherViewController(model: Sunny())
        let view = viewController.weatherView
        let imageView = view.weatherImageView
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(imageView.image!, UIImage(named: "sunny")!)
    }
    func test_天気予報がcloudyだったときに画面に晴れ画像が表示される() {
        
        struct Cloudy: Testable {
            func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
                .success(WeatherInformation(weather: .cloudy, minTemperature: "0", maxTemperature: "0"))
            }
        }
        let viewController = WeatherViewController(model: Cloudy())
        let view = viewController.weatherView
        let imageView = view.weatherImageView
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(imageView.image!, UIImage(named: "cloudy")!)
    }
    func test_天気予報がrainyだったときに画面に晴れ画像が表示される() {
        
        struct Rainy: Testable {
            func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
                .success(WeatherInformation(weather: .rainy, minTemperature: "0", maxTemperature: "0"))
            }
        }
        let viewController = WeatherViewController(model: Rainy())
        let view = viewController.weatherView
        let imageView = view.weatherImageView
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(imageView.image!, UIImage(named: "rainy")!)
    }
    func test_最高気温がUILabelに反映される() {
        
        struct MaxTemperature: Testable {
            
            let maxTemperature: String
            
            init(maxTemperature: String) {
                self.maxTemperature = maxTemperature
            }
            func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
                .success(WeatherInformation(weather: .sunny, minTemperature: "0", maxTemperature: maxTemperature))
            }
        }
        
        let testingMaxTemperature = "40"
        let viewController = WeatherViewController(model: MaxTemperature(maxTemperature: testingMaxTemperature))
        let view = viewController.weatherView
        let maxTemperature = view.maxTemperatureLabel
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(maxTemperature.text, testingMaxTemperature)
    }
    
    func test_最低気温がUILabelに反映される() {
        
        struct MinTemperature: Testable {
            
            let minTemperature: String
            
            init(minTemperature: String) {
                self.minTemperature = minTemperature
            }
            func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
                .success(WeatherInformation(weather: .sunny, minTemperature: minTemperature, maxTemperature: "0"))
            }
        }
        
        let testingMinTemperature = "-40"
        let viewController = WeatherViewController(model: MinTemperature(minTemperature: testingMinTemperature))
        let view = viewController.weatherView
        let minTemperature = view.minTemperatureLabel
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(minTemperature.text, testingMinTemperature)
    }
    

}

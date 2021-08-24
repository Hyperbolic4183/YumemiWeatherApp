//
//  Yumemi_ios_trainingTests.swift
//  Yumemi-ios-trainingTests
//
//  Created by 大塚 周 on 2021/06/18.
//

import XCTest
@testable import Yumemi_ios_training

struct TestWeatherModel: Fetchable {
    let weatherInformation: WeatherInformation
    init(weatherInformation: WeatherInformation) {
        self.weatherInformation = weatherInformation
    }
    func fetchYumemiWeather() -> Result<WeatherInformation, WeatherAppError> {
        .success(weatherInformation)
    }
}

class Yumemi_ios_trainingTests: XCTestCase {
    
    func test_天気予報がsunnyだったときに画面に晴れ画像が表示される() {
        let sunnyWeatherInformation = WeatherInformation(weather: .sunny, minTemperature: "0", maxTemperature: "0")
        let sunnyModel = TestWeatherModel(weatherInformation: sunnyWeatherInformation)
        
        let viewController = WeatherViewController(model: sunnyModel)
        let view = viewController.weatherView
        let imageView = view.weatherImageView
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(imageView.image!, UIImage(named: "sunny")!)
    }
    func test_天気予報がcloudyだったときに画面に曇り画像が表示される() {
        let cloudyWeatherInformation = WeatherInformation(weather: .cloudy, minTemperature: "0", maxTemperature: "0")
        let cloudyModel = TestWeatherModel(weatherInformation: cloudyWeatherInformation)
        
        let viewController = WeatherViewController(model: cloudyModel)
        let view = viewController.weatherView
        let imageView = view.weatherImageView
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(imageView.image!, UIImage(named: "cloudy")!)
    }
    func test_天気予報がrainyだったときに画面に雨画像が表示される() {
        
        let rainyWeatherInformation = WeatherInformation(weather: .rainy, minTemperature: "0", maxTemperature: "0")
        let rainyModel = TestWeatherModel(weatherInformation: rainyWeatherInformation)
        
        let viewController = WeatherViewController(model: rainyModel)
        let view = viewController.weatherView
        let imageView = view.weatherImageView
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(imageView.image!, UIImage(named: "rainy")!)
    }
    func test_最高気温がUILabelに反映される() {
        
        let testingMaxTemperature = "40"
        let maxTemperatureWeatherInformation = WeatherInformation(weather: .sunny, minTemperature: "0", maxTemperature: testingMaxTemperature)
        let maxTemperatureModel = TestWeatherModel(weatherInformation: maxTemperatureWeatherInformation)
        
        let viewController = WeatherViewController(model: maxTemperatureModel)
        let view = viewController.weatherView
        let maxTemperature = view.maxTemperatureLabel
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(maxTemperature.text, testingMaxTemperature)
    }
    
    func test_最低気温がUILabelに反映される() {

        let testingMinTemperature = "-40"
        let minTemperatureWeatherInformation = WeatherInformation(weather: .sunny, minTemperature: testingMinTemperature, maxTemperature: "0")
        let minTemperatureModel = TestWeatherModel(weatherInformation: minTemperatureWeatherInformation)
        
        let viewController = WeatherViewController(model: minTemperatureModel)
        let view = viewController.weatherView
        let minTemperature = view.minTemperatureLabel
        let reloadButton = view.reloadButton
        
        viewController.viewDidLoad()
        reloadButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(minTemperature.text, testingMinTemperature)
    }
}

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
        let sunnyWeatherInformation = WeatherInformation(weather: .sunny, minTemperature: "0", maxTemperature: "0")
        let view = WeatherView()
        view.changeDisplay(WeatherViewState(information: sunnyWeatherInformation))
        let weatherImage = getImage(from: view)
        XCTAssertEqual(weatherImage, UIImage(named: "sunny"))
    }
    func test_天気予報がcloudyだったときに画面に曇り画像が表示される() {
        let cloudyWeatherInformation = WeatherInformation(weather: .cloudy, minTemperature: "0", maxTemperature: "0")
        let view = WeatherView()
        view.changeDisplay(WeatherViewState(information: cloudyWeatherInformation))
        let weatherImage = getImage(from: view)
        XCTAssertEqual(weatherImage, UIImage(named: "cloudy"))
    }
    func test_天気予報がrainyだったときに画面に雨画像が表示される() {
        let rainyWeatherInformation = WeatherInformation(weather: .rainy, minTemperature: "0", maxTemperature: "0")
        let view = WeatherView()
        view.changeDisplay(WeatherViewState(information: rainyWeatherInformation))
        let weatherImage = getImage(from: view)
        XCTAssertEqual(weatherImage, UIImage(named: "rainy"))
    }
    func test_最高気温がUILabelに反映される() {
        let testMaxTemperature = "40"
        let view = WeatherView()
        let minTemperatureWeatherInformation = WeatherInformation(weather: .sunny, minTemperature: "0", maxTemperature: testMaxTemperature)
        view.changeDisplay(WeatherViewState(information: minTemperatureWeatherInformation))
        let maxTemperatureLabel = getMaxTemperatureLabel(from: view)
        XCTAssertEqual(maxTemperatureLabel.text, testMaxTemperature)
    }
    
    func test_最低気温がUILabelに反映される() {
        let testMinTemperature = "-40"
        let view = WeatherView()
        let minTemperatureWeatherInformation = WeatherInformation(weather: .sunny, minTemperature: testMinTemperature, maxTemperature: "0")
        view.changeDisplay(WeatherViewState(information: minTemperatureWeatherInformation))
        let minTemperatureLabel = getMinTemperatureLabel(from: view)
        XCTAssertEqual(minTemperatureLabel.text, testMinTemperature)
    }
    
    private func getStackView(from view: UIView) -> UIStackView {
        view.subviews.first(where: { $0 is UIStackView})! as! UIStackView
    }
    
    private func getImage(from view: WeatherView) -> UIImage? {
        //WeatherView含まれるstackViewForImageViewAndLabelsを取得
        let stackViewForImageViewAndLabels = getStackView(from: view)
        let weatherImageView = stackViewForImageViewAndLabels.subviews.first(where: { $0 is UIImageView })! as! UIImageView
        return weatherImageView.image
    }
    
    private func getMaxTemperatureLabel(from view: WeatherView) -> UILabel {
        //WeatherView含まれる2つのUIStackViewのうち、2番目に追加したstackViewForLabelsを取得
        let stackViewForImageViewAndLabels = getStackView(from: view)
        //stackViewForImageViewAndLabelsに含まれるstackViewForLabelsを取得
        let stackViewForLabels = getStackView(from: stackViewForImageViewAndLabels)
        //stackViewForLabelsに2番目に追加したUILabelを取得
        let maxTemperatureLabel = stackViewForLabels.subviews[1] as! UILabel
        return maxTemperatureLabel
    }
    private func getMinTemperatureLabel(from view: WeatherView) -> UILabel {
        //WeatherView含まれるstackViewForImageViewAndLabelsを取得
        let stackViewForImageViewAndLabels = getStackView(from: view)
        //stackViewForImageViewAndLabelsに含まれるstackViewForLabelsを取得
        let stackViewForLabels = getStackView(from: stackViewForImageViewAndLabels)
        //stackViewForLabelsに初めに追加したUILabelを取得
        let minTemperatureLabel = stackViewForLabels.subviews[0] as! UILabel
        return minTemperatureLabel
    }
}

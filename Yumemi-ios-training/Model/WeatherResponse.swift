//
//  WeatherResponse.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/06/11.
//
import Foundation
struct WeatherResponse: Codable {
    let weather: String
    let min_temp: Int
    let max_temp: Int
    let date: Date
}

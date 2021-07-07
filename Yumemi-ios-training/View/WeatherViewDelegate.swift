//
//  WeatherViewDelegate.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/07/02.
//

protocol WeatherViewDelegate: AnyObject {
    func didTapReloadButton(_ view: WeatherView)
    func didTapCloseButton(_ view: WeatherView)
}


//
//  InitialViewController.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/06/11.
//

import UIKit

class InitialViewController: UIViewController {
    
    let fetchYumemiWeather = FetchYumemiWeather.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var fetcher = Fetcher()
        fetcher.delegate = fetchYumemiWeather
        let weatherViewController = WeatherViewController(model: fetcher)
        weatherViewController.modalPresentationStyle = .fullScreen
        present(weatherViewController, animated: true)
    }
}

//
//  InitialViewController.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/06/11.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let fetcher = Fetcher()
        let weatherViewController = WeatherViewController(model: fetcher)
        weatherViewController.modalPresentationStyle = .fullScreen
        present(weatherViewController, animated: true)
    }
}

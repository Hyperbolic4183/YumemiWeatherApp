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
        
        let weatherViewController = WeatherViewController(model: Fetcher())
        weatherViewController.modalPresentationStyle = .fullScreen
        present(weatherViewController, animated: true)
    }
}

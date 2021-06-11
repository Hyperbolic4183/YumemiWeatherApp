//
//  InitialViewController.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/06/11.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        let weatherViewController = WeatherViewController(model: Fetcher())
        weatherViewController.modalPresentationStyle = .fullScreen
        present(weatherViewController, animated: true, completion: nil)
    }
}

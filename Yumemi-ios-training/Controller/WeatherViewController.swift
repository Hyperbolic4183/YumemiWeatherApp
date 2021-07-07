//
//  ViewController.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/04/30.
//

import UIKit


class WeatherViewController: UIViewController, WeatherViewDelegate {
    let weatherView = WeatherView()
    var weatherModel: Fetchable
    
    init(model: Fetchable) {
        self.weatherModel = model
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.delegate = self
    }
    
    func updateView(_ result: Result<WeatherInformation, WeatherAppError>) {
        switch result {
        case .success(let information):
            let weatherViewState = WeatherViewState(information: information)
            weatherView.changeDisplay(weatherViewState)
        case .failure(let error):
            var message = ""
            switch error {
            case .invalidParameterError:
                message = "不適切な値が設定されました"
            case .unknownError:
                message = "予期せぬエラーが発生しました"
            }
            presentAlertController(message)
        }
    }
    
    func showIndicator(processing:@escaping () -> Result<WeatherInformation, WeatherAppError>, completion: @escaping (_ result: Result<WeatherInformation, WeatherAppError>) -> Void) {
        let globalQueue = DispatchQueue.global(qos: .userInitiated)
        let mainQueue = DispatchQueue.main
        weatherView.operateIndicator()
        globalQueue.async {
            let result = processing()
            mainQueue.async {
                completion(result)
                self.weatherView.operateIndicator()
            }
        }
    }
    
    @objc func reload(_ sender: UIButton) {
        showIndicator(processing: self.weatherModel.fetchYumemiWeather) { result in
            self.updateView(result)
        }
    }
    
    func presentAlertController(_ message: String) {
        let errorAlert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(errorAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    func didTapReloadButton(_ view: WeatherView) {
        showIndicator(processing: self.weatherModel.fetchYumemiWeather) { result in
            self.updateView(result)
        }
    }

    func didTapCloseButton(_ view: WeatherView) {
        self.dismiss(animated: true, completion: nil)
    }
}




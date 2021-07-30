//
//  ViewController.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/04/30.
//

import UIKit

class WeatherViewController: UIViewController {
    private let weatherView = WeatherView()
    private var weatherModel: Fetchable
    
    init(model: Fetchable) {
        self.weatherModel = model
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    deinit {
        print("WeatherViewController released")
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
        weatherModel.delegate = self
    }
    
    private func updateView(onSuccess information: WeatherInformation) {
        let weatherViewState = WeatherViewState(information: information)
        weatherView.changeDisplay(weatherViewState)
    }
    
    private func updateView(onFailure error: WeatherAppError) {
        var message = ""
        switch error {
        case .invalidParameterError:
            message = "不適切な値が設定されました"
        case .unknownError:
            message = "予期せぬエラーが発生しました"
        }
        presentAlertController(message)
    }
    
    @objc func reload() {
        weatherView.switchIndicatorAnimation()
        weatherModel.fetch()
    }
    
    func presentAlertController(_ message: String) {
        let errorAlert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(errorAction)
        present(errorAlert, animated: true, completion: nil)
    }
}

// MARK:- WeatherViewDelegate

extension WeatherViewController: WeatherViewDelegate {
    
    func didTapReloadButton(_ view: WeatherView) {
        reload()
    }

    func didTapCloseButton(_ view: WeatherView) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK:- FetcherDelegate
extension WeatherViewController: FetcherDelegate {
    
    func fetcher(_ fetcher: Fetchable?, didFetch information: WeatherInformation) {
        DispatchQueue.main.async { [weak self] in
            self?.updateView(onSuccess: information)
            self?.weatherView.switchIndicatorAnimation()
        }
    }
    
    func fetcher(_ fetcher: Fetchable?, didFailWithError error: WeatherAppError) {
        DispatchQueue.main.async { [weak self] in
            self?.updateView(onFailure: error)
            self?.weatherView.switchIndicatorAnimation()
        }
    }
}

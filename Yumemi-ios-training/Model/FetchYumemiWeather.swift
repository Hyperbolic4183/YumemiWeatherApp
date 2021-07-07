//
//  FetchYumemiWeather.swift
//  Yumemi-ios-training
//
//  Created by 大塚 周 on 2021/07/07.
//

import YumemiWeather

class FetchYumemiWeather: FetcherDelegate {
    
    var fetcher = Fetcher()
    
    init() {
        fetcher.delegate = self
    }
    
    func syncFetchWeather(_ jsonString: String) throws -> String {
        try YumemiWeather.syncFetchWeather(jsonString)
    }
}

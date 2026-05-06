//
//  ExchangeRatesProtocols.swift
//  Bank App
//
//  Created by Egor on 06.05.2026.
//

import Foundation

// То, что presenter будет вызывать у View
protocol ExchangeRatesViewProtocol: AnyObject {
    func showLoading()
    func showRates(_ rates: [ExchangeRatesModel])
    func showError(_ message: String)
}

// То, что View будет вызывать у presenter
protocol ExchangeRatesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func reloadTapped()
}

protocol ExchangeRatesRouterProtocol: AnyObject {
    func openExchangeRates()
}

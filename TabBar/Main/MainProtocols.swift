//
//  MainProtocols.swift
//  Bank App
//
//  Created by Egor on 09.05.2026.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func getUserName(name: String)
}

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func exchangeRatesTapped()
    func newsTapped()
    func bankTapped()
}

protocol MainRouterProtocol: AnyObject {
    func openExchangeRates()
    func openNews()
    func openBankLocation()
}

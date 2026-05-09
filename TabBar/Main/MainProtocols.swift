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
}

protocol MainRouterProtocol: AnyObject {
    func openExchangeRates()
    func openNews()
}

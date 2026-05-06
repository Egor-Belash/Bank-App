//
//  ExchangeRatesPresenter.swift
//  Bank App
//
//  Created by Egor on 06.05.2026.
//

import Foundation

final class ExchangeRatesPresenter: ExchangeRatesPresenterProtocol {
    
    // MARK: – Properties
    weak var view: ExchangeRatesViewProtocol?
    private var rates: [ExchangeRatesModel] = []
    var router: ExchangeRatesRouterProtocol?
    
    init(view: ExchangeRatesViewProtocol? = nil) {
        self.view = view
    }

    func viewDidLoad() {
        fetchRates()
    }
    
    func reloadTapped() {
        fetchRates()
    }
    
    func exchangeRateTapped() {
        router?.openExchangeRates()
    }
    
    private func fetchRates() {
        NetworkService.shared.fetchExchangeRates { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rates):
                    self?.rates = rates
                    self?.view?.showRates(rates)
                case .failure(let error):
                    self?.view?.showError("Failed to fetch data\n\(error.localizedDescription)")
                }
            }
        }
    }
}

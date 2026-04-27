//
//  ExchangeRatesViewController.swift
//  Bank App
//
//  Created by Egor on 27.04.2026.
//

import UIKit

final class ExchangeRatesViewController: UIViewController {
    
    // MARK: – Properties
    private var rates: [ExchangeRatesModel] = []
    
    // MARK: – Subviews
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
        fetchExchangeRates()
        
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        setupTextIntoLabel()
        
        view.addSubview(activityIndicator)
        view.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }
    
    // MARK: – Actions
    private func fetchExchangeRates() {
        activityIndicator.startAnimating()
        
        NetworkService.shared.fetchExchangeRates { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                switch result {
                case .success(let rates):
                    self?.rates = rates
                    self?.setupTextIntoLabel()
                case .failure(let error):
                    self?.label.text = "Failed to fetch data:\n\(error.localizedDescription)"
                }
            }
        }
    }
    
    private func setupTextIntoLabel() {
        guard let rate = rates.first else {
            label.text = "Загрузка ..."
            return
        }
                
                
        label.text = """
        Курс на \(rate.kursDateTime)
        
                        Обмен валюты
        
        Валюта:        Покупка:        Продажа:
        🇺🇸 USD:        \(rate.usdCardIn)        \(rate.usdCardOut)
        🇪🇺 EUR:        \(rate.eurCardIn)        \(rate.eurCardOut)
        🇷🇺 RUB:        \(rate.rubCardIn)        \(rate.rubCardOut)
        🇨🇳 CNY:        \(rate.cnyCardIn)        \(rate.cnyCardOut)
        
                    Обмен иностранной валюты
        
        Валюта:             Покупка:        Продажа:
        🇺🇸USD–🇪🇺EUR:        \(rate.usdEurCardIn)        \(rate.usdEurCardOut)
        🇺🇸USD–🇷🇺RUB:        \(rate.usdRubCardIn)        \(rate.usdRubCardOut)
        🇷🇺RUB–🇪🇺EUR:        \(rate.rubEurCardIn)        \(rate.rubEurCardOut)
        🇨🇳CNY–🇺🇸USD:        \(rate.cnyUsdCardIn)        \(rate.cnyUsdCardOut)
        🇨🇳CNY–🇪🇺EUR:        \(rate.cnyEurCardIn)        \(rate.cnyEurCardOut)
        🇨🇳CNY–🇷🇺RUB:        \(rate.cnyRubCardIn)        \(rate.cnyRubCardOut)
        """
    }
    
}



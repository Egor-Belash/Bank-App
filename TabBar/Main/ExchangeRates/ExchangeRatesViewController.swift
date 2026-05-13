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
    var presenter: ExchangeRatesPresenterProtocol?
    
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
    
    private let reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 25
        button.isHidden = true
        return button
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
        activityIndicator.startAnimating()
        presenter?.viewDidLoad()
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        setupTextIntoLabel()
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        
        view.addSubview(activityIndicator)
        view.addSubview(label)
        view.addSubview(reloadButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: 100),
            reloadButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: – Actions
    private func setupTextIntoLabel() {
        label.isHidden = false
        guard let rate = rates.first else {
            label.text = String(localized: .loading)
            return
        }
        
        label.text = """
        \(String(localized: .exchangeRateOn(variableName: "\(rate.kursDateTime)")))
        
                        \(String(localized: .currencyExchange))
        
        \(String(localized: .currency)):        \(String(localized: .buy)):        \(String(localized: .sell)):
        🇺🇸 USD:        \(rate.usdCardIn)        \(rate.usdCardOut)
        🇪🇺 EUR:        \(rate.eurCardIn)        \(rate.eurCardOut)
        🇷🇺 RUB:        \(rate.rubCardIn)        \(rate.rubCardOut)
        🇨🇳 CNY:        \(rate.cnyCardIn)        \(rate.cnyCardOut)
        
                    \(String(localized: .foreignCurrencyExchange))
        
        \(String(localized: .currency)):             \(String(localized: .buy)):        \(String(localized: .sell)):
        🇺🇸USD–🇪🇺EUR:        \(rate.usdEurCardIn)        \(rate.usdEurCardOut)
        🇺🇸USD–🇷🇺RUB:        \(rate.usdRubCardIn)        \(rate.usdRubCardOut)
        🇷🇺RUB–🇪🇺EUR:        \(rate.rubEurCardIn)        \(rate.rubEurCardOut)
        🇨🇳CNY–🇺🇸USD:        \(rate.cnyUsdCardIn)        \(rate.cnyUsdCardOut)
        🇨🇳CNY–🇪🇺EUR:        \(rate.cnyEurCardIn)        \(rate.cnyEurCardOut)
        🇨🇳CNY–🇷🇺RUB:        \(rate.cnyRubCardIn)        \(rate.cnyRubCardOut)
        """
    }
    
    private func showReloadButton() {
        label.isHidden = false
        reloadButton.isHidden = false
    }
    
    @objc private func reloadButtonTapped() {
        presenter?.reloadTapped()
    }
    
}

// MARK: – ExchangeRatesViewProtocol
extension ExchangeRatesViewController: ExchangeRatesViewProtocol {
    func showLoading() {
        activityIndicator.startAnimating()
        label.isHidden = true
        reloadButton.isHidden = true
    }
    
    func showRates(_ rates: [ExchangeRatesModel]) {
        self.rates = rates
        activityIndicator.stopAnimating()
        label.isHidden = false
        setupTextIntoLabel()
    }
    
    func showError(_ message: String) {
        activityIndicator.stopAnimating()
        label.text = message
        showReloadButton()
    }
}

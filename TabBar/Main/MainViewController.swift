//
//  ViewController.swift
//  Bank App
//
//  Created by Egor on 30.03.2026.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: – Properties
    var presenter: MainPresenterProtocol?
    
    // MARK: – Subviews
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let exchangeRatesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: .exchangeRates), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "yellowColor2")
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = .init(width: 2, height: 2)
        return button
    }()
    
    private let newsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: .news), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "blueColor2")
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = .init(width: 2, height: 2)
        return button
    }()

    private let bankButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: .news), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "blueColor2")
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = .init(width: 2, height: 2)
        return button
    }()

    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()

        presenter?.viewDidLoad()
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        exchangeRatesButton.addTarget(self, action: #selector(exchangeRatesButtonTapped), for: .touchUpInside)
        newsButton.addTarget(self, action: #selector(newsButtonTapped), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(exchangeRatesButton)
        view.addSubview(newsButton)
        view.addSubview(bankButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            exchangeRatesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            exchangeRatesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            exchangeRatesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            exchangeRatesButton.heightAnchor.constraint(equalToConstant: 50),
            
            newsButton.topAnchor.constraint(equalTo: exchangeRatesButton.bottomAnchor, constant: 50),
            newsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            newsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            newsButton.heightAnchor.constraint(equalToConstant: 50),

            bankButton.topAnchor.constraint(equalTo: newsButton.bottomAnchor, constant: 50),
            bankButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            bankButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            bankButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: – Actions
    @objc private func exchangeRatesButtonTapped() {
        presenter?.exchangeRatesTapped()
    }
    
    @objc private func newsButtonTapped() {
        presenter?.newsTapped()
    }

    @objc private func bankButtonTapped() {
        presenter?.bankTapped()
    }
    
}

extension MainViewController: MainViewProtocol {
    func getUserName(name: String) {
        label.text = String(localized: .greeting(variableName: name))
    }
    
}

//
//  SettingsViewController.swift
//  Bank App
//
//  Created by Egor on 01.04.2026.
//
import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: – Properties
    
    // MARK: – Subviews
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        return label
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 22
        button.backgroundColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemGray
    }
    
    private func setupSubviews() {
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(logOutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logOutButton.heightAnchor.constraint(equalToConstant: 44),
            logOutButton.widthAnchor.constraint(equalToConstant: 130),
            
        ])
    }
    
    // MARK: – Actions
    @objc private func logOutButtonTapped() {
        showWarningAlertBeforeExit(title: "Attention", message: "You are going to log out.\nAre you sure?")
    }
    
    
    private func showWarningAlertBeforeExit(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { [weak self] _ in
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            self?.dismiss(animated: true)
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(logOutAction)
        
        present(alert, animated: true)
    }
    
}


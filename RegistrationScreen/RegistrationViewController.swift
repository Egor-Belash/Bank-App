//
//  RegistrationViewController.swift
//  Bank App
//
//  Created by Egor on 01.04.2026.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: – Properties
    
    // MARK: – Subviews
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imageBackground2")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 1
        return blurView
    }()
    
    private let youAreNotRegisteredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You are not registered?😱"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 3)
        label.layer.shadowOpacity = 0.3
        return label
    }()
    
    private let registrationView: RegistrationView = {
        let view = RegistrationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
        setupGestures()
        overrideUserInterfaceStyle = .light
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitButtonTapped))
        
        registrationView.delegate = self
        
        view.addSubview(imageView)
        view.addSubview(blurView)
        view.addSubview(youAreNotRegisteredLabel)
        view.addSubview(registrationView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            youAreNotRegisteredLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            youAreNotRegisteredLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registrationView.topAnchor.constraint(equalTo: youAreNotRegisteredLabel.bottomAnchor, constant: 30),
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registrationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    // MARK: – Actions
    @objc private func exitButtonTapped() {
        dismiss(animated: true)
    }
    
    // скрытие клавиатуры по тапу в любой части экрана
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: – RegistrationViewDelegate
extension RegistrationViewController: RegistrationViewDelegate {
    func showError(title: String, message: String) {
        showSimpleAlert(title: title, message: message)
    }
    
    func saveButtonTapped() {
        self.dismiss(animated: true)
    }
    
}

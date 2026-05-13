//
//  RegistrationViewController.swift
//  Bank App
//
//  Created by Egor on 01.04.2026.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: – Properties
    var presenter: RegistrationPresenterProtocol?

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
        label.text = String(localized: .registrationTitle)
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 3)
        label.layer.shadowOpacity = 0.3
        label.numberOfLines = 0
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
            youAreNotRegisteredLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            youAreNotRegisteredLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            registrationView.topAnchor.constraint(equalTo: youAreNotRegisteredLabel.bottomAnchor, constant: 30),
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registrationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    // MARK: – Actions
    @objc private func exitButtonTapped() {
        presenter?.exitButtonTapped()
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
    func saveButtonTapped() {
        presenter?.saveButtonTapped()
    }
    
}

// MARK: – RegistrationViewDelegate
extension RegistrationViewController: RegistrationViewProtocol {
    func getLogin() -> String {
        return registrationView.getLogin()
    }

    func getPassword() -> String {
        return registrationView.getPassword()
    }
    
    func getSecondPassword() -> String {
        return registrationView.getSecondPassword()
    }

    func getName() -> String {
        return registrationView.getName()
    }

    func getPhone() -> String {
        return registrationView.getPhone()
    }

    func getEmail() -> String {
        return registrationView.getEmail()
    }    

    func setTextFieldsColor(_ textField: RegistrationTextFields) {
        registrationView.setTextFieldsColor(textField)
    }

    func clearTextFieldsColor() {
        registrationView.clearTextFieldsColor()
    }

    func showError(title: String, message: String) {
        showSimpleAlert(title: title, message: message)
    }

}


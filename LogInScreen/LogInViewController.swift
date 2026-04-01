//
//  LogInViewController.swift
//  Bank App
//
//  Created by Egor on 30.03.2026.
//

import UIKit

final class LogInViewController: UIViewController {
    
    // MARK: – Properties
    
    // MARK: – Subviews
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imageBackground1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bank App"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let logInView: LogInView = {
        let view = LogInView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        logInView.delegate = self
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(logInView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logInView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            logInView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logInView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logInView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
    
}

extension LogInViewController: LogInViewDelegate {
    func loginButtonTaped(login: String, password: String) {
        if password == "" || login == "" {
            showSimpleAlert(title: "Ошибка", message: "Неверный логин или пароль")
        } else {
            let vc = MainTabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func registrationButtonTaped() {
        let vc = RegistrationViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
}

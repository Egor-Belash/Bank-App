//
//  LogInViewController.swift
//  Bank App
//
//  Created by Egor on 30.03.2026.
//

import UIKit

final class LogInViewController: UIViewController {
    
    // MARK: – Properties
    private let savedLogin = ""
    private let savedPassword = ""
    
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
        
        setupGestures()
        
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logInView.cleanTextFields()
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
    
    // MARK: – Actions
    // скрытие клавиатуры по тапу в любой части экрана
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

}

// MARK: – LogInViewDelegate
extension LogInViewController: LogInViewDelegate {
    
    func loginButtonTaped(login: String, password: String) {
        guard !login.isEmpty, !password.isEmpty else {
            showSimpleAlert(title: "Ошибка", message: "Введите логин и пароль")
            return
        }
        
        guard let savedLogin = UserDefaults.standard.string(forKey: "login") else {
            showSimpleAlert(title: "Ошибка", message: "Пользователь не зарегистрирован")
            return
        }
        
        guard let savedPassword = KeychainService.shared.loadPasswordFromKeychain(login: savedLogin) else {
            showSimpleAlert(title: "Ошибка", message: "Пароль не найден")
            return
        }
        
        if login == savedLogin && password == savedPassword {
            // If user us LoggedIn, he will be loggedIn directly to the MainTabBarViewController
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
            // Go to the MainTabBarViewController
            goToMainTabBarScreen()
        } else {
            showSimpleAlert(title: "Ошибка", message: "Неверный логин или пароль")
        }
    }
    
    func registrationButtonTaped() {
        let vc = RegistrationViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    private func goToMainTabBarScreen() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else
        { return }
        
        window.rootViewController = MainTabBarViewController()
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionFlipFromBottom,
            animations: nil,
            completion: nil
        )
    }
    
}

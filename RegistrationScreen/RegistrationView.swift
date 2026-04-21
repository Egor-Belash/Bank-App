//
//  RegistrationView.swift
//  Bank App
//
//  Created by Egor on 01.04.2026.
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func saveButtonTapped()
    func showError(title: String, message: String)
}

final class RegistrationView: UIView {
    
    // MARK: – Properties
    weak var delegate: RegistrationViewDelegate?
    
    // MARK: – Subviews
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Придумайте логин"
        label.textColor = .black
        return label
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Логин"
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Придумайте надёжный пароль"
        label.textColor = .black
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Пароль"
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let secondPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введите пароль повторно"
        label.textColor = .black
        return label
    }()
    
    private let secondPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Пароль"
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введите ваше имя"
        label.textColor = .black
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Имя"
        textField.returnKeyType = .continue
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Укажите вашу дату рождения"
        label.textColor = .black
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.date = Date()
        return picker
    }()
    
    
    // MARK: – INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 2, height: 2)
        layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    private func setupSubviews() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        secondPasswordTextField.delegate = self
        nameTextField.delegate = self
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(loginLabel)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(secondPasswordLabel)
        contentView.addSubview(secondPasswordTextField)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(dateOfBirthLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(saveButton)
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 5),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            secondPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            secondPasswordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            secondPasswordTextField.topAnchor.constraint(equalTo: secondPasswordLabel.bottomAnchor, constant: 5),
            secondPasswordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            secondPasswordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            secondPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: secondPasswordTextField.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            dateOfBirthLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor, constant: 5),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    // MARK: – Actions
    @objc private func saveButtonTapped() {
        guard checkIfPasswordsAreEqual() else { return }
    
        saveData()
        delegate?.saveButtonTapped()
    }
    
    private func saveData() {
        if let login = loginTextField.text, !login.isEmpty {
            UserDefaults.standard.set(login, forKey: "login")
        }
        
        if let password = passwordTextField.text, !password.isEmpty {
            UserDefaults.standard.set(password, forKey: "password")
        }
        
        if let name = nameTextField.text, !name.isEmpty {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    
    private func checkIfPasswordsAreEqual() -> Bool {
        guard let password = passwordTextField.text,
              let secondPassword = secondPasswordTextField.text else { return false }
        
        if password.isEmpty || secondPassword.isEmpty {
            passwordTextField.backgroundColor = .red
            secondPasswordTextField.backgroundColor = .red
            delegate?.showError(title: "Ошибка", message: "Поля должны быть заполнены")
            return false
        }
        
        if password != secondPassword {
            secondPasswordTextField.backgroundColor = .red
            delegate?.showError(title: "Ошибка", message: "Пароли должны совпадать")
            return false
        } else {
            secondPasswordTextField.backgroundColor = .systemBackground
        }
        return true
    }
    
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            secondPasswordTextField.becomeFirstResponder()
        case secondPasswordTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            nameTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

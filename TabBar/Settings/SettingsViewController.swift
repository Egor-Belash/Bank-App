//
//  SettingsViewController.swift
//  Bank App
//
//  Created by Egor on 01.04.2026.
//
import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: – Properties
    var presenter: SettingsPresenterProtocol?
    
    // MARK: – Subviews
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        return label
    }()
    
    private let nightModeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Theme:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let nightModeSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["System", "Light", "Dark"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private let notificationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enable notifications:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let notificationSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.isOn = false
        return switcher
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
        setupNavigationBar()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        nightModeSegment.addTarget(self, action: #selector(nightModeSegmentChanged), for: .valueChanged)
        notificationSwitch.addTarget(self, action: #selector(notificationSwitchTapped), for: .valueChanged)
        
        view.addSubview(label)
        view.addSubview(nightModeLabel)
        view.addSubview(nightModeSegment)
        view.addSubview(notificationsLabel)
        view.addSubview(notificationSwitch)
        view.addSubview(logOutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nightModeLabel.centerYAnchor.constraint(equalTo: nightModeSegment.centerYAnchor),
            nightModeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nightModeLabel.trailingAnchor.constraint(equalTo: nightModeSegment.leadingAnchor, constant: -20),
            
            nightModeSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nightModeSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nightModeSegment.heightAnchor.constraint(equalToConstant: 34),
            nightModeSegment.widthAnchor.constraint(equalToConstant: 200),
            
            notificationsLabel.centerYAnchor.constraint(equalTo: notificationSwitch.centerYAnchor),
            notificationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notificationsLabel.trailingAnchor.constraint(equalTo: notificationSwitch.leadingAnchor, constant: -20),
            
            notificationSwitch.topAnchor.constraint(equalTo: nightModeSegment.bottomAnchor, constant: 30),
            notificationSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logOutButton.heightAnchor.constraint(equalToConstant: 44),
            logOutButton.widthAnchor.constraint(equalToConstant: 130),
            
        ])
    }
    
    private func setupNavigationBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: – Actions
    @objc private func logOutButtonTapped() {
        showWarningAlertBeforeExit(title: "Attention", message: "You are going to log out.\nAre you sure?")
    }
    
    @objc private func nightModeSegmentChanged(_ segment: UISegmentedControl) {
        presenter?.nightModeSegmentTapped(segment.selectedSegmentIndex)
    }
    
    @objc private func notificationSwitchTapped(_ sender: UISwitch) {
        presenter?.notificationSwitchTapped(sender.isOn)
    }
    
    private func showWarningAlertBeforeExit(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { [weak self] _ in
            self?.presenter?.logoutButtonTapped()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(logOutAction)
        
        present(alert, animated: true)
    }
    
}

// MARK: – SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
    func loadThemeValue(_ value: Int) {
        nightModeSegment.selectedSegmentIndex = value
    }
    
    func setTextForNotification(_ text: String) {
        notificationsLabel.text = text
    }
    
    func setSwitchIsOn(_ isOn: Bool) {
        notificationSwitch.setOn(isOn, animated: true)
    }
    
    func showAlertToOpenSettings() {
        let alert = UIAlertController(
            title: "Уведомления отключены",
            message: "Разрешите уведомления в настройках устройства",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        alert.addAction(UIAlertAction(title: "Настройки", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        present(alert, animated: true)

    }

}
